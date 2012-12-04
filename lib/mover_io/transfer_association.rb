module MoverIO
  class Transfer
    attr_accessor :id,
      :status,
      :source,
      :destination,
      :bytes_in,
      :bytes_out,
      :files_in,
      :files_out,
      :start_time,
      :end_time,
      :options

    def new_record?
      !id.nil?
    end
  end

  class TransferAssociation < Struct.new(:session)

    def create(source_connector, source_collection, destination_connector, destination_collection)
      payload = {
        :source => {
          :connector_id => source_connector.id,
          :collection_id => source_collection.id
        }, 
        :destination => {
          :connector_id => destination_connector.id,
          :collection_id => destination_collection.id
        }
      }
      response = session.post "/transfers", payload
      if response
        Transfer.new(nil) # TODO: parse this up
      end
    end

  end
end

