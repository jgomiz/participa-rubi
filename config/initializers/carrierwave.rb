# frozen_string_literal: true

if Rails.env.production? || Rails.env.staging?
  CarrierWave.configure do |config|
    config.fog_provider = "fog/aws"
    config.fog_credentials = {
      provider:              "AWS",
      aws_access_key_id:     Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
      region:                "eu-west-1"
    }
    config.fog_directory = Rails.application.secrets.aws_s3_bucket
    config.fog_attributes = { "Cache-Control" => "max-age=#{365.days.to_i}" }
    config.storage = :fog
  end
else
  CarrierWave.configure do |config|
    config.permissions = 0o666
    config.directory_permissions = 0o777
    config.storage = :file
    config.enable_processing = !Rails.env.test?
  end
end
