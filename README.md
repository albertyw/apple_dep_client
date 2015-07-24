# Apple Device Enrollment Program Client

[ ![Codeship Status for cellabus/apple_dep_client](https://codeship.com/projects/c0524f60-c7a7-0132-b06e-4a390261e3f5/status?branch=master)](https://codeship.com/projects/74982)
[![Dependency Status](https://gemnasium.com/df107f4e9f06f63f6e4f56c3565c0717.svg)](https://gemnasium.com/cellabus/apple_dep_client)
[![Code Climate](https://codeclimate.com/repos/554866aee30ba0688c0138df/badges/a40843b11a586c566c43/gpa.svg)](https://codeclimate.com/repos/554866aee30ba0688c0138df/feed)
[![Test Coverage](https://codeclimate.com/repos/554866aee30ba0688c0138df/badges/a40843b11a586c566c43/coverage.svg)](https://codeclimate.com/repos/554866aee30ba0688c0138df/coverage)

This gem allows for easy interaction with the Apple DEP API.

## Installation
Read this gem from Github.  Since it's a private repository, you may want to
refer to http://stackoverflow.com/a/13261333.

This gem requires an updated version of the `plist` gem from
https://github.com/cellabus/plist so you may want to add
`gem 'plist', git: 'https://github.com/cellabus/plist', ref: '3.1.2'` to your
software's `Gemfile`.

This gem also also requires `OpenSSL` to be installed.  You can test it by
running `require 'openssl'` in `irb` and checking that it works.

This will be uploaded to https://rubygems.org/ some day.

## Usage

See Apple's `Mobile Device Management Protocol Reference` for more information
about the high level usage of their DEP Workflow.  All commands are under the
`AppleDEPClient` namespace.  `AppleDEPClient` will
automatically handle OAuth for DEP endpoints.

## Getting DEP Server Tokens

In order for you to read the DEP tokens returned by Apple from a DEP account,
you must decrypt it using a private key.  This will give the individual
keys needed for issuing commands to the DEP devices.

```ruby
AppleDEPClient.configure do |config|
  config.private_key = 'PRIVATE_KEY'
end
# Get S/MIME encrypted Server Token from Apple
token_data = AppleDEPClient::Token.decode_token(smime_data)
token_data[:consumer_key]
token_data[:consumer_secret]
...
```

## Interacting with DEP endpoints

The main DEP management commands are issued like this.  See Apple's
`MDM Protocol Reference` for information about all the commands.

```ruby
AppleDEPClient.configure do |config|
  config.consumer_key        = token_data[:consumer_key]        # XXX
  config.consumer_secret     = token_data[:consumer_secret]     # XXX
  config.access_token        = token_data[:access_token]        # XXX
  config.access_secret       = token_data[:access_secret]       # XXX
  config.access_token_expiry = token_data[:access_token_expiry] # XXX
end

data = AppleDEPClient::Account.fetch()
data["server_name"]
data["server_uuid"]
data["org_name"]
...
```

The full list of commands is

```
AppleDEPClient::Account.fetch
AppleDEPClient::Device.fetch(cursor: nil)
AppleDEPClient::Device.sync(cursor){|device| pass }
AppleDEPClient::Device.details(devices)
AppleDEPClient::Device.disown(devices)
AppleDEPClient::Profile.define(profile_hash)
AppleDEPClient::Profile.assign(profile_uuid, devices)
AppleDEPClient::Profile.fetch(profile_uuid)
AppleDEPClient::Profile.remove(devices)
```

## Device Callbacks

After assigning a DEP profile to a device, the device will hit the `url` in the profile.
The returned data will be "encoded as a XML plist and then CMS-signed and DER-encoded"
and can be parsed as below:

```ruby
data = AppleDEPClient::Callback.decode_callback(request_body)
data["UDID"]
data["SERIAL"]
...
```

## Depsim

There is an example script at `example/example.rb` which can be run against
Apple's DEP simulator.  You'll need to download the simulator binary and
run it with `path/to/depsim start -p 80 example/depsim_config.json`.  You can
then run the script using `bundle exec ruby example/example.rb`.  `example.rb`
can of course be edited to use real DEP keys for manual DEP work (but be
careful to keep the keys secret).
