require "spec_helper"

module MoverIO
  describe Connector do
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

      it "should cache" do
        session.expects(:get).twice.returns({"connectors" => []})
        session.connections.all
        session.connections.all # this should be a cached call
        session.connections.all(true)
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

    describe "#find" do
    end

  end
end
