# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "apple_dep_client/version"

Gem::Specification.new do |spec|
  spec.name          = "apple_dep_client"
  spec.version       = AppleDEPClient::VERSION
  spec.license       = "AGPL-3.0"
  spec.authors       = ["Albert Wang"]
  spec.email         = ["git@albertyw.com"]
  spec.summary       = "Client for Apple Device Enrollment Program"
  spec.description   = "This gem provides an easy way to authenticate and interact with Apple's Device Enrollment Program"
  spec.homepage      = "https://github.com/albertyw/apple_dep_client"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "oauth", "~> 0.5.6"
  spec.add_dependency "typhoeus", [">= 0.7", "< 1.2"]
  spec.add_dependency "plist", ">= 3.1" # See Gemfile
  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", ">= 10"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "simplecov", "~> 0.21.2"
end
