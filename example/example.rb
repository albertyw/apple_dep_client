# This file is an example script prepopulated with data for depsim, Apple's
# DEP simulator

require "apple_dep_client"
require "securerandom"

# depsim
AppleDEPClient.configure do |x|
  x.apple_dep_server = "http://localhost"
  x.consumer_key = "CK_48dd68d198350f51258e885ce9a5c37ab7f98543c4a697323d75682a6c10a32501cb247e3db08105db868f73f2c972bdb6ae77112aea803b9219eb52689d42e6"
  x.consumer_secret = "CS_34c7b2b531a600d99a0e4edcf4a78ded79b86ef318118c2f5bcfee1b011108c32d5302df801adbe29d446eb78f02b13144e323eb9aad51c79f01e50cb45c3a68"
  x.access_token = "AT_927696831c59ba510cfe4ec1a69e5267c19881257d4bca2906a99d0785b785a6f6fdeb09774954fdd5e2d0ad952e3af52c6d8d2f21c924ba0caf4a031c158b89"
  x.access_secret = "AS_c31afd7a09691d83548489336e8ff1cb11b82b6bca13f793344496a556b1f4972eaff4dde6deb5ac9cf076fdfa97ec97699c34d515947b9cf9ed31c99dded6ba"
end

device_serials = []
p "Devices:"
AppleDEPClient::Device.fetch do |device|
  p device
  device_serials << device["serial_number"]
end

DEFAULT_DEP_PROFILE_DATA = {
  profile_name: "DEP Profile",
  url: "http://localhost:5000/dep_checkin",
  is_supervised: true,
  is_mandatory: true,
  is_mdm_removable: false,
  support_phone_number: "123-456-7890",
  support_email_address: "support@cellabus.com",
  org_magic: SecureRandom.uuid,
  skip_setup_items: [:biometric, :siri],
  department: "Foo",
}

profile = AppleDEPClient::Profile.define(DEFAULT_DEP_PROFILE_DATA)
profile_uuid = profile["profile_uuid"]
p "Profile UUID:"
p profile_uuid
p "Assigning profile to devices:"
p AppleDEPClient::Profile.assign(profile_uuid, device_serials)
p "Fetching profile info:"
p AppleDEPClient::Profile.fetch(profile_uuid)
