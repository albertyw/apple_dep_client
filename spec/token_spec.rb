require 'spec_helper'

describe "AppleDEPClient::Token" do
  describe ".decode_token" do
    xit "can receive and decrypt an AppleDEPClient Token" do

    end
  end

  describe ".parse_data" do
    let(:data) { '{"consumer_key": "asdf"}' }
    it 'can parse JSON data and return it' do
      expect(AppleDEPClient::Token.parse_data(data)).to eq ({consumer_key: 'asdf'})
    end
    it 'will save JSON data' do
      expect(AppleDEPClient::Token).to receive(:save_data)
      AppleDEPClient::Token.parse_data(data)
    end
  end

  describe ".save_data" do
    let(:data) { {consumer_key: 'asdf', access_token: 'qwer'} }
    it 'can save data' do
      AppleDEPClient::Token.save_data(data)
      expect(AppleDEPClient.consumer_key).to eq 'asdf'
      expect(AppleDEPClient.access_token).to eq 'qwer'
    end
  end
end
