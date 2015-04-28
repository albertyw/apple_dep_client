require 'spec_helper'

describe AppleDEPClient::Profile do
  describe ".define" do
    it "sends a profile to apple" do
      data = {profile_name: 'asdf'}
      expect(AppleDEPClient::Request).to receive(:make_request).with(AppleDEPClient::Profile::DEFINE_URL, :post, '{"profile_name":"asdf"}').once
      AppleDEPClient::Profile.define data
    end
    it "doesn't send unrecognized data to apple" do
      data = {asdf: 'asdf'}
      expect(AppleDEPClient::Request).to receive(:make_request).with(AppleDEPClient::Profile::DEFINE_URL, :post, '{}').once
      AppleDEPClient::Profile.define data
    end
  end
end
