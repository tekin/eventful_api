# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eventful_api/version'

Gem::Specification.new do |gem|
  gem.name          = "eventful_api"
  gem.version       = EventfulApi::VERSION
  gem.authors       = ["Tekin Suleyman"]
  gem.email         = ["tekin@tekin.co.uk"]
  gem.description   = %q{Ruby library for accessing the eventful.com API}
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/tekin/eventful_api"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency  "oauth", ["~> 0.3.6"]

  gem.add_development_dependency  "test-unit", ["~> 2.5.4"]
end
