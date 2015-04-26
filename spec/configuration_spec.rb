require 'spec_helper'

describe "AppleDEPClient::Configuration" do
  it "can be configured" do
    AppleDEPClient.private_key = 'asdf'
    AppleDEPClient.consumer_key = 'qwer'
    expect(AppleDEPClient.private_key).to eq 'asdf'
    expect(AppleDEPClient.consumer_key).to eq 'qwer'
  end

  describe ".method_missing" do
    it "can get value for valid configuration keys" do
      expect(AppleDEPClient).to receive(:get_value).with(:access_token).and_return 'asdf'
      expect(AppleDEPClient.access_token).to eq 'asdf'
    end
    it "can raise NoMethodError for invalid configuration keys" do
      expect{AppleDEPClient.asdf}.to raise_error NoMethodError
    end
  end

  describe ".get_value" do
    it "can get a configuration value directly from the saved value" do
      AppleDEPClient.private_key = 'qwer'
      expect(AppleDEPClient.private_key).to eq 'qwer'
    end
    it "can get a configuration value by calling a Proc" do
      AppleDEPClient.private_key = lambda { return 'qwer' }
      expect(AppleDEPClient.private_key).to eq 'qwer'
    end
  end

  describe ".configure" do
    it "can be configured in a block" do
      AppleDEPClient.configure do |x|
        x.private_key = 'asdf'
      end
      expect(AppleDEPClient.private_key).to eq 'asdf'
    end
  end
end
