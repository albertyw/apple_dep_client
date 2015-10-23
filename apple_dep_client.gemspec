# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "apple_dep_client/version"

Gem::Specification.new do |spec|
  spec.name          = "apple_dep_client"
  spec.version       = AppleDEPClient::VERSION
  spec.licenses      = ["MIT"]
  spec.authors       = ["Albert Wang"]
  spec.email         = ["albert@cellabus.com"]
  spec.summary       = "Client for Apple Device Enrollment Program"
  spec.description   = "This gem provides an easy way to authenticate and interact with Apple's Device Enrollment Program"
  spec.homepage      = "https://github.com/cellabus/apple_dep_client"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "oauth", "~> 0.4.7"
  spec.add_dependency "typhoeus", "~> 0.7"
  spec.add_dependency "plist", "~> 3.1.0" # See Gemfile
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0"
end
