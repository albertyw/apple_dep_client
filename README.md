# Apple Device Enrollment Program Client

[ ![Codeship Status for cellabus/apple_dep_client](https://codeship.com/projects/c0524f60-c7a7-0132-b06e-4a390261e3f5/status?branch=master)](https://codeship.com/projects/74982)

This gem allows for easy interaction with the Apple DEP API.

## Installation
Read this gem from Github.  Since it's a private repository, you may want to
refer to http://stackoverflow.com/a/13261333.

This gem also requires an updated version of the `plist` gem from
https://github.com/cellabus/plist so you may want to add
`gem 'plist', git: 'https://github.com/cellabus/plist', ref: '3.1.2'` to your
software's `Gemfile`.

## Usage

See Apple's `Mobile Device Management Protocol Reference` for more information
about the high level usage of their DEP Workflow.  All commands are under the
`AppleDEPClient` namespace.  `AppleDEPClient` will
automatically handle OAuth for DEP endpoints.

## Getting DEP Server Tokens

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

e.g.

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

## Device Callbacks

After assigning a DEP profile to a device, the device will hit the `url` in the profile.
The returned data will be "encoded as a XML plist and then CMS-signed and DER-encoded"
and can be parsed as below:

``ruby
data = AppleDEPClient::Callback.decode_callback(request_body)
data["UDID"]
data["SERIAL"]
...
```
