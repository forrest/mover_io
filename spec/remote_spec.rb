require "spec_helper"

describe "Run tests against actual API" do


  describe "checking all connections" do
    mover_app_id = ENV['MOVER_API_ID'] || "9adkJ9EGmMop3XjBJeNjWJBeMijQkQGq"
    mover_app_secret = ENV['MOVER_API_SECRET'] || "Q9Ow8a9IYQqDJIU9SYi1zO4aWcOv2B05"
    session = MoverIO::Session.new(:app_id => mover_app_id, :app_secret => mover_app_secret)

    session.connections.all
  end

end
