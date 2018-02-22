# frozen_string_literal: true

module HttpBasicAuthenticable
  extend ActiveSupport::Concern

  included do
    before_action :http_basic_authentication, if: :password_protected_organization?
  end

  private

  def password_protected_organization?
    return false if current_organization.blank? ||
                    Rails.application.secrets.http_basic_authentication[:name].blank? ||
                    Rails.application.secrets.http_basic_authentication[:password].blank?
    current_organization.http_basic_authentication_protected?
  end

  def http_basic_authentication
    request_http_basic_authentication unless http_basic_authenticated?
  end

  def http_basic_authenticated?
    authenticate_with_http_basic do |name, password|
      name == Rails.application.secrets.http_basic_authentication.fetch(:name) &&
        password == Rails.application.secrets.http_basic_authentication.fetch(:password)
    end
  end
end
