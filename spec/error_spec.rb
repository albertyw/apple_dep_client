require 'spec_helper'

describe AppleDEPClient::Error do
  describe AppleDEPClient::Error::RequestError do
    subject { AppleDEPClient::Error::RequestError }
    let(:body) { 'asdf' }
    it "takes a body" do
      expect { raise subject.new(body) }.to raise_error RuntimeError
    end
  end
  describe AppleDEPClient::Error::AuthBadRequest do
    subject { AppleDEPClient::Error::AuthBadRequest }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::AuthUnauthorized do
    subject { AppleDEPClient::Error::AuthUnauthorized }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::AuthForbidden do
    subject { AppleDEPClient::Error::AuthForbidden }
    specify { expect(subject).to be }
  end
end
