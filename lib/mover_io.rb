require 'rest-client'
require 'json'

module MoverIO
  class Session
    DEFAULT_HOST = 'api.mover.io'
    DEFAULT_PROTOCOL = 'http://'

    def initialize(options)
      @app_id = options[:app_id]
      @app_secret = options[:app_secret]

      @host =  options.has_key?(:host) ? options[:host] : DEFAULT_HOST
      @protocol =  options.has_key?(:protocol) ? options[:protocol] : DEFAULT_PROTOCOL
    end


    ############ CONNECTORS ################
    def available_connectors
      response = RestClient.get "#{base_url}/connectors/available"
      if response.code == 200
        JSON.parse response.to_str
      else
        false
      end
    end

    def find_connector(connector_id)
      p "MoverAPI app_id=#{@app_id} app_secret=#{@app_secret}"
      response = RestClient.get "#{base_url}/connectors/#{connector_id}", {:authorization => "MoverAPI app_id=#{@app_id} app_secret=#{@app_secret}"}
      if response.code == 200
        JSON.parse response.to_str
      else
        false
      end
    end

    def create_connector(type)
      response = RestClient.post "#{base_url}/connectors", { 'type' => type }.to_json, {:authorization => "MoverAPI app_id=#{@app_id} app_secret=#{@app_secret}", :content_type => :json}
      if response.code == 201
        JSON.parse response.to_str
      else
        false
      end
    end


    ############ COLLECTIONS ################
    def find_collection(connector_id, collection_id = nil)
      response = RestClient.get "#{base_url}/connectors/#{connector_id}/collections/#{collection_id}", {:authorization => "MoverAPI app_id=#{@app_id} app_secret=#{@app_secret}"}
      if response.code == 200
        JSON.parse response.to_str
      else
        false
      end
    end

    ############ TRANSFER ################
    def create_transfer(source_connector_id, source_collection_id, destination_connector_id, destination_collection_id )
      payload = {:source => {:connector_id => source_connector_id, :collection_id => source_collection_id}, :destination => {:connector_id => destination_connector_id, :collection_id => destination_collection_id}}
      response = RestClient.post "#{base_url}/transfers", payload.to_json, {:authorization => "MoverAPI app_id=#{@app_id} app_secret=#{@app_secret}", :content_type => :json}
      if response.code == 201
        JSON.parse response.to_str
      else
        false
      end
    end


    private

    def base_url
      @protocol + @host
    end
  end
end

