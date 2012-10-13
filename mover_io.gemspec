# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mover_io/version'

Gem::Specification.new do |gem|
  gem.name          = "mover_io"
  gem.version       = MoverIo::VERSION
  gem.authors       = ["Ben Zittlau"]
  gem.email         = ["ben@zittlau.ca"]
  gem.description = "Ruby gem for the Mover.io API"
  gem.summary     = "Ruby gem for the Mover.io API"
  gem.homepage      = "http://mover.io"

  gem.add_dependency "rest-client"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
