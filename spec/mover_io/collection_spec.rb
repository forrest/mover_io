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

        connection.collections.root.should == Collection.new(
          connection,
          "ID2",
          "/",
          true,
          "parent_id",
          []
        )
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

        connection.collections.find("ID2").should == Collection.new(
          connection,
          "ID2",
          "/",
          true,
          "parent_id",
          []
        )
      end
    end

    describe "#create" do
    end

  end
end
