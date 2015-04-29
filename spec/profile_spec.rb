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
  describe ".assign" do
    it "sends a request to assign a profile to data" do
      expect(AppleDEPClient::Request).to receive(:make_request).with(AppleDEPClient::Profile::ASSIGN_URL, :put, anything).once
      AppleDEPClient::Profile.assign('1', 'a')
    end
  end
  describe ".fetch" do
    it "sends a request to fetch a profile" do
      expect(AppleDEPClient::Request).to receive(:make_request).with(AppleDEPClient::Profile::FETCH_URL, :get, nil, params:anything).once
      AppleDEPClient::Profile.fetch('1')
    end
  end
  describe ".remove" do
    it "sends a request to remove profiles from devices" do
      expect(AppleDEPClient::Request).to receive(:make_request).with(AppleDEPClient::Profile::REMOVE_URL, :delete, anything).once
      AppleDEPClient::Profile.remove('a')
    end
  end
end
