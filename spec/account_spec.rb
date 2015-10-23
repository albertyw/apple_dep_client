require "spec_helper"

describe AppleDEPClient::Account do
  it "can fetch data" do
    url = AppleDEPClient::Request.make_url(AppleDEPClient::Account::FETCH_PATH)
    expect(AppleDEPClient::Request).to receive(:make_request).with(url, :get, "").and_return("asdf").once
    expect(AppleDEPClient::Account.fetch).to eq "asdf"
  end
end
