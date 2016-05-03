module NoiseProxy
  class Proxy

    TWO_POWERS = (0..7).map { |n| 2 ** n }

    attr_accessor :host, :port, :incoming_factor, :outgoing_factor

    def initialize
      @incoming_factor = 0
      @outgoing_factor = 0
    end

    def start(port)
      EventMachine.start_server('0.0.0.0', port, FrontEnd) do |conn|
        conn.proxy = self
        conn.connect_upstream(@host, @port)
      end
    end

    def noise_incoming(data)
      fuzz_string(data, @incoming_factor)
    end

    def noise_outgoing(data)
      fuzz_string(data, @outgoing_factor)
    end

    def fuzz_string(data, factor)
      bytes = data.bytes.map do |byte|
        TWO_POWERS.each do |power|
          byte ^= power if rand <= factor
        end
        byte
      end
      bytes.pack('c*')
    end

    module FrontEnd
      attr_accessor :proxy, :backend

      def connect_upstream(host, port)
        return unless host and port

        EventMachine.connect(host, port, BackEnd) do |conn|
          self.backend  = conn

          conn.proxy    = proxy
          conn.frontend = self
        end
      end

      def receive_data(data)
        backend.send_data(proxy.noise_outgoing(data))
      end
    end

    module BackEnd
      attr_accessor :proxy, :frontend

      def receive_data(data)
        frontend.send_data(proxy.noise_incoming(data))
      end
    end

  end
end
