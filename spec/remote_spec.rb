require "spec_helper"

describe "Run tests against actual API" do

  def session
    @session ||= (
      mover_app_id = CONFIG['mover_api_id']
      mover_app_secret = CONFIG['mover_api_secret']
      MoverIO::Session.new(:app_id => mover_app_id, :app_secret => mover_app_secret)
    )
  end

  it "should fetch all connections" do
    session.connections.all
  end

  it "should find a known connector" do
    session.connections.find(CONFIG[:known_connector_id])
  end

end
