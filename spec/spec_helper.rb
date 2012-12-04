require "mover_io"
require "mocha"
require 'rest-client'

CONFIG = YAML::load(File.open('config.yml'))["test"]

