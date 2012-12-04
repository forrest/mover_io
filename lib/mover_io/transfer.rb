module MoverIO
  class Transfer
    attr_accessor :session
    ATTRS = [ :id,
              :status,
              :source,
              :destination,
              :bytes_in,
              :bytes_out,
              :files_in,
              :files_out,
              :start_time,
              :end_time,
              :options ]
    attr_accessor(*ATTRS)

    def initialize(session, attr)
      self.session = session
      self.attributes = attr
    end

    def attributes=(hash)
      hash.each{|key, value|
        send("#{key}=", value) if ATTRS.collect(&:to_s).include?(key)
      }
    end

    def new_record?
      !id.nil?
    end
  end

  class TransferAssociation < Struct.new(:session)
    def all
      res = session.get("/transfers")
      if res
        res["transfers"].map{|transfer|
          Transfer.new(session, res)
        }
      else
        []
      end
    end

    def create(source_connector, source_collection, destination_connector, destination_collection, options = {})
      payload = {
        "source" => {
          "connector_id" => source_connector.id,
          "collection_id" => source_collection.id
        },
        "destination" => {
          "connector_id" => destination_connector.id,
          "collection_id" => destination_collection.id
        }
      }
      response = session.post "/transfers", payload
      if response
        Transfer.new(session, payload.merge(response))
      end
    end

  end
end

