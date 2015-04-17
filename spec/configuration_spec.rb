require 'spec_helper'

describe "AppleDEPClient::Configuration" do
  it "can be configured" do
    AppleDEPClient.public_key = 'asdf'
    AppleDEPClient.consumer_key = 'qwer'
    expect(AppleDEPClient.public_key).to eq 'asdf'
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
      AppleDEPClient.public_key = 'qwer'
      expect(AppleDEPClient.public_key).to eq 'qwer'
    end
    it "can get a configuration value by calling a Proc" do
      AppleDEPClient.public_key = lambda { return 'qwer' }
      expect(AppleDEPClient.public_key).to eq 'qwer'
    end
  end

  describe ".configure" do
    it "can be configured in a block" do
      AppleDEPClient.configure do |x|
        x.public_key = 'asdf'
      end
      expect(AppleDEPClient.public_key).to eq 'asdf'
    end
  end
end
