require "spec_helper"

module MoverIO
  describe "ConnectorAssociation" do
    let(:session) { Session.new({}) }

    describe "#all" do
      it "should list types" do
        session.expects(:get).with("/connectors").returns({
          "connector_count" => 2,
          "page" => 1,
          "connectors" => [
            {
              "id" => "Has397ftbwA96aHgoEa",
              "type" => "Dropbox"
            },
            {
              "id" => "SD96aHgoEagas397ftb",
              "type" => "SugarSync"
            }
          ]
        })

        session.connections.all.should =~ [
          Connector.new(session, "Has397ftbwA96aHgoEa", "Dropbox"),
          Connector.new(session, "SD96aHgoEagas397ftb", "SugarSync")
        ]
      end
    end

    describe "#new" do
      it "should send a post with the corect type" do
        session.expects(:post).with("/connectors", {'type' => 'Dropbox'}).returns({
          "id" => "Has397ftbwA96aHgoEa",
          "type" => "Dropbox"
        })

        connector = session.connections.create("Dropbox")
        connector.id.should == "Has397ftbwA96aHgoEa"
        connector.type.should == "Dropbox"
      end
    end

  end
end
