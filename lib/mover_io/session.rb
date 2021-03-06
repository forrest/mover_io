require 'rest-client'
require 'json'

module MoverIO
  class Session
    DEFAULT_HOST = 'api.mover.io'
    DEFAULT_PROTOCOL = 'https://'

    def initialize(options)
      @app_id = options[:app_id]
      @app_secret = options[:app_secret]

      @host =  options.has_key?(:host) ? options[:host] : DEFAULT_HOST
      @protocol =  options.has_key?(:protocol) ? options[:protocol] : DEFAULT_PROTOCOL
    end

    def get(path)
      rest_client(:get, path, {})
    end

    def put(path, params = {})
      rest_client(:put, path, params)
    end

    def post(path, params = {})
      rest_client(:post, path, params)
    end

    def delete(path, params = {})
      rest_client(:delete, path, params)
    end

    def connections
      @connections ||= ConnectorAssociation.new(self)
    end

    def transfers
      @transfers ||= TransferAssociation.new(self)
    end

    private

    def rest_client(method, path, params)
      args = [method, "#{base_url}#{path}"]
      args << params.to_json unless method == :get
      args << auth_hash.merge(content_type_hash)

      res = self.class.rest_client_class.send(*args)
      if res.code >= 200 and res.code < 300
        JSON.parse res.to_str
      else
        nil
      end
    end

    def self.rest_client_class; RestClient; end

    def auth_hash
      {:authorization => "MoverAPI app_id=#{@app_id} app_secret=#{@app_secret}"}
    end

    def content_type_hash
      {:content_type => :json}
    end

    def base_url
      @protocol + @host
    end
  end
end
