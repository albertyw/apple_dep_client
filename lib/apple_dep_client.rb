require "apple_dep_client/version"
require "apple_dep_client/error"
require "apple_dep_client/configuration"

module AppleDEPClient
  extend Configuration
end

require "apple_dep_client/token"
require "apple_dep_client/auth"
require "apple_dep_client/callback"

require "apple_dep_client/request"
require "apple_dep_client/account"
require "apple_dep_client/device"
require "apple_dep_client/profile"
