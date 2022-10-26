# frozen_string_literal: true

class WsAuthorizationHandler < Decidim::AuthorizationHandler
  attr_writer :soap_client

  attribute :document_number, String
  attribute :year, String

  validates :document_number, presence: true
  validates :year, presence: true

  validate :valid_document_number
  validate :valid_year

  def initialize(params)
    super(params)
  end

  def unique_id
    Digest::MD5.hexdigest(
      "#{document_number}-#{year}-#{Rails.application.secrets.secret_key_base}"
    )
  end

  private

  def valid_document_number
    errors.add(:base, :invalid) unless in_participation_registry?(document_number, year)
  end

  def valid_year
    errors.add(:year, :invalid) if year.to_i < 1900 || year.to_i > Time.zone.now.year
  end

  def in_participation_registry?(document_number, year)
    response = participation_registry_check(document_number, year)
    response.body.dig(:entries, :entry, :participa).to_i == 1
  end

  def normalize(document_number)
    return nil if document_number.nil?

    document_number.delete("- \t\r\n").upcase.strip
  end

  def participation_registry_check(document_number, year)
    soap_client.call(:get_dni_any, message: {
      dni: normalize(document_number),
      any_naixement: normalize(year)
    })
  end

  def soap_client
    @soap_client ||
      Savon.client(wsdl: participation_registry_endpoint(wsdl: true),
                   endpoint: participation_registry_endpoint,
                   convert_request_keys_to: :none)
  end

  def participation_registry_endpoint(wsdl: false)
    return Rails.application.secrets.participation_registry_ws_url unless wsdl
    "#{Rails.application.secrets.participation_registry_ws_url}?wsdl"
  end
end
