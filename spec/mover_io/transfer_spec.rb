require "spec_helper"

module MoverIO
  describe Transfer do
    let(:session) { Session.new({}) }

    describe "#all" do
    end

    describe "#create" do
      it "should send the correct post" do
        source_connection = Connector.new(session, "ID1")
        destination_connection = Connector.new(session, "ID2")
        source_collection = source_connection.collections.new("id" => "ID3")
        destination_collection = source_connection.collections.new("id" => "ID4")

        session.expects(:post).with("/transfers", {
          "source" => {
            "connector_id" => "ID1",
            "collection_id" => "ID3"
          },
          "destination" => {
            "connector_id" => "ID2",
            "collection_id" => "ID4"
          }
        }).returns({
          "id" => "ID"
        })

        transfer = session.transfers.create(source_connection,
                                            source_collection,
                                            destination_connection,
                                            destination_collection)
        transfer.id.should == "ID"
        transfer.source["connector_id"].should == source_connection.id
      end
    end

  end
end

