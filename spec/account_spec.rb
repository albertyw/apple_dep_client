require 'spec_helper'

describe AppleDEPClient::Account do
  it "can fetch data" do
    expect(AppleDEPClient::Request).to receive(:make_request).with(AppleDEPClient::Account::URL, :get, '').and_return('asdf').once
    expect(AppleDEPClient::Account.fetch).to eq 'asdf'
  end
end
