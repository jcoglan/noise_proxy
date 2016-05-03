module NoiseProxy
  class API

    def initialize(proxy)
      @proxy = proxy

      proxy.host = 'www.example.com'
      proxy.port = 80
    end

    def call(env)
      request = Rack::Request.new(env)
      params  = request.params

      if request.post?
        @proxy.host = params['host']
        @proxy.port = params['port'].to_i
        @proxy.incoming_factor = params['incoming'].to_f
        @proxy.outgoing_factor = params['outgoing'].to_f
        respond(201, {})
      elsif request.get?
        state = {
          'host'     => @proxy.host,
          'port'     => @proxy.port,
          'incoming' => @proxy.incoming_factor,
          'outgoing' => @proxy.outgoing_factor
        }
        respond(200, state)
      end
    end

  private

    def respond(status, data)
      body = JSON.dump(data)

      headers = {
        'Content-Length' => body.bytesize.to_s,
        'Content-Type'   => 'application/json; charset=utf-8'
      }

      [status, headers, [body]]
    end

  end
end
