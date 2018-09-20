require_relative 'production.rb'

Rails.application.configure do
  config.action_mailer.delivery_method = :letter_opener_web
end
