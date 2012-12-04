require "spec_helper"

module MoverIO
  describe Collection do
    let(:session) { Session.new({}) }
    let(:connection) { Connector.new(session, "ID") }

    describe "#root" do
      it "should parse the JSON response" do
        session.expects(:get).with("/connectors/ID/collections", {}).returns({
          "id" => "ID2",
          "name" => "/",
          "writable" => true,
          "parent_id" => "parent_id",
          "contents" => []
        })

        root = connection.collections.root
        root.id.should == "ID2"
        root.name.should == "/"
        root.should be_writable
        root.parent_id.should == "parent_id"
      end
    end

    describe "#find" do
      it "should parse the JSON response" do
        session.expects(:get).with("/connectors/ID/collection/ID2", {}).returns({
          "id" => "ID2",
          "name" => "/",
          "writable" => true,
          "parent_id" => "parent_id",
          "contents" => []
        })

        collection = connection.collections.find("ID2")
        collection.id.should == "ID2"
        collection.name.should == "/"
        collection.should be_writable
        collection.parent_id.should == "parent_id"
      end
    end

    describe "#create" do
    end

  end
end
