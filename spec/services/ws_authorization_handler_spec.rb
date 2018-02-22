# frozen_string_literal: true

require "rails_helper"

RSpec.describe WsAuthorizationHandler, type: :service do
  let(:soap_client) do
    double(:soap_client).tap do |client|
      allow(client).to receive(:call).and_return(failed_response)
      allow(client).to receive(:call).with(:get_dni, message: { dni: "123456" })
                                     .and_return(successful_response)
    end
  end
  let(:successful_response) do
    double(:successful_response, body: { entries: { entry: { inscrit: "mars-id" } } })
  end
  let(:failed_response) { double(:failed_response, body: {}) }

  describe "#valid?" do
    it "is valid if the document can be found" do
      handler = WsAuthorizationHandler.new(document_number: "123456")
      handler.soap_client = soap_client

      expect(handler.valid?).to eq(true)
    end

    it "is not valid for other document numbers" do
      handler = WsAuthorizationHandler.new(document_number: "455667")
      handler.soap_client = soap_client

      expect(handler.valid?).to eq(false)
    end
  end

  describe "#unique_id" do
    it "returns the id returned by the WS if found" do
      handler = WsAuthorizationHandler.new(document_number: "123456")
      handler.soap_client = soap_client

      handler.valid?

      expect(handler.unique_id).to eq("mars-id")
    end

    it "returns nil if the document is not found in the WS" do
      handler = WsAuthorizationHandler.new(document_number: "20946")
      handler.soap_client = soap_client

      handler.valid?

      expect(handler.unique_id).to eq(nil)
    end
  end
end
