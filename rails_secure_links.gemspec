# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_secure_links/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_secure_links"
  spec.version       = RailsSecureLinks::VERSION
  spec.authors       = ["Naum Kostovski"]
  spec.email         = ["kostovski.naum@gmail.com"]
  spec.summary       = %q{Ruby on Rails gem implementation of nginx secure links}
  spec.description   = %q{Protect unauthorized access to your uploaded assets using nginx secure links module}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
