# Apple Device Enrollment Program Client

This gem allows for easy interaction with the Apple DEP API.

## Usage

See Apple's `Mobile Device Management Protocol Reference` for more information
about the high level usage of their DEP Workflow.  All commands are under the
`AppleDEPClient` namespace.  `AppleDEPClient` will
automatically handle OAuth for DEP endpoints.

## Getting DEP Server Tokens

```ruby
AppleDEPClient.configure do |config|
  config.public_key = 'PUBLIC_KEY'
  config.private_key = 'PRIVATE_KEY'
end
# Get S/MIME encrypted Server Token from Apple
token_data = AppleDEPClient::Token.decode_token(smime_data)
```

Afterwards, all usage of the `AppleDEPClient` should include:

```ruby
AppleDEPClient.configure do |config|
  config.consumer_key = # XXX
  config.consumer_secret = # XXX
  config.access_token = # XXX
  config.access_secret = # XXX
  config.access_token_expiry = # XXX
end
```

## Interacting with DEP endpoints

e.g.

```ruby
response = AppleDEPClient.get_account_details()
response.server_name
response.server_uuid
response.facilitator_id
response.org_name
response.org_email
response.org_phone
response.org_address
```
