require "mover_io"
require "mocha"
require 'rest-client'

begin
  CONFIG = YAML::load(File.open('config.yml'))["test"]
rescue Errno::ENOENT
  puts "\nIt looks like you haven't copied over sample.config.yml into a configuration file!\nRemote Specs will fail."
  CONFIG = {}
end

