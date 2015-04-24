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
  describe AppleDEPClient::Error::MalformedRequest do
    subject { AppleDEPClient::Error::MalformedRequest }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::Unauthorized do
    subject { AppleDEPClient::Error::Unauthorized }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::Forbidden do
    subject { AppleDEPClient::Error::Forbidden }
    specify { expect(subject).to be }
  end
  describe AppleDEPClient::Error::MethodNotAllowed do
    subject { AppleDEPClient::Error::MethodNotAllowed }
    specify { expect(subject).to be }
  end
end
