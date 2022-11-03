# frozen_string_literal: true

class WsAuthorizationHandler < Decidim::AuthorizationHandler
  attr_writer :soap_client

  DNI_REGEXP = /\d{8}[a-z]/i.freeze
  NIE_REGEXP = /[a-z]\d{7}[a-z]/i.freeze
  PASSPORT_REGEXP = /[a-z]{2}[a-z]?[0-9]{6}[a-z]?$/i.freeze
  DOCUMENT_REGEXP = /\A(#{DNI_REGEXP}|#{NIE_REGEXP}|#{PASSPORT_REGEXP})\z/.freeze

  attribute :document_number, String
  attribute :year, String

  validates(
    :document_number,
    format: { with: DOCUMENT_REGEXP },
    presence: true
  )
  validates(
    :year,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: Date.today.year - 120,
      less_than_or_equal_to: Date.today.year - 15
    },
    presence: true
  )
  validate :check_response

  def unique_id
    Digest::MD5.hexdigest(
      "#{document_number}-#{year}-#{Rails.application.secrets.secret_key_base}"
    )
  end

  private

  def check_response
    response = participation_registry_check(document_number, year)
    response_code = if response
      response.body.dig(:entries, :entry, :participa)
    else
      nil
    end

    errors.add(:base, I18n.t("ws_authorization_handler.invalid_message")) if response.blank? || response_code&.to_i != 1
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
  rescue Savon::SOAPFault => error
    puts "[Census] SOAP error: #{error}"
    return nil
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
