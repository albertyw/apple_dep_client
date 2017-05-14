require "simplecov"
SimpleCov.start

require "apple_dep_client"

RSpec.configure do |config|
  config.before(:each) do
    AppleDEPClient.configure do |client|
      client.private_key = nil
      client.consumer_key = nil
      client.consumer_secret = nil
      client.access_token = nil
      client.access_secret = nil
      client.access_token_expiry = nil
      client.apple_dep_server = nil
    end
  end
end
