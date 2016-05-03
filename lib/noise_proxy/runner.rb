module NoiseProxy
  class Runner

    def initialize(port)
      @port = port
    end

    def start
      proxy = Proxy.new
      api   = API.new(proxy)

      stack = Rack::Builder.new do
        map '/api' do
          run api
        end
        use Rack::Static, :urls => [''], :root => ASSET_DIR, :index => 'index.html'
        run -> {}
      end

      EventMachine.run do
        proxy.start(@port)

        handler = Rack::Handler.get('thin')
        handler.run(stack, :Port => @port + 1)

        Signal.trap('INT') { EventMachine.stop }
      end
    end

  end
end
