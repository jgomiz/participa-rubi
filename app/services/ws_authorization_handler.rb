# frozen_string_literal: true

class WsAuthorizationHandler < Decidim::AuthorizationHandler
  attr_writer :soap_client

  attribute :document_number, String

  validates :document_number, presence: true
  validate :valid_document_number

  def initialize(params)
    super(params)
  end

  def unique_id
    @ws_user_unique_id
  end

  private

  def valid_document_number
    errors.add(:document_number, :invalid) unless in_participation_registry?(document_number)
  end

  def in_participation_registry?(document_number)
    response = participation_registry_check(document_number)
    @ws_user_unique_id = response.body.dig(:entries, :entry, :inscrit)
    @ws_user_unique_id.present?
  end

  def normalize(document_number)
    document_number.delete("- \t\r\n").upcase
  end

  def participation_registry_check(document_number)
    soap_client.call(:get_dni, message: { dni: normalize(document_number) })
  end

  def soap_client
    @soap_client ||
      Savon.client(wsdl: participation_registry_endpoint(wsdl: true),
                   endpoint: participation_registry_endpoint)
  end

  def participation_registry_endpoint(wsdl: false)
    return Rails.application.secrets.participation_registry_ws_url unless wsdl
    "#{Rails.application.secrets.participation_registry_ws_url}?wsdl"
  end
end
