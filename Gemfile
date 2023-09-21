# frozen_string_literal: true

DECIDIM_VERSION = "0.26.3"

source "https://rubygems.org"

ruby "2.7.5"

gem "decidim", DECIDIM_VERSION

gem "pg"
gem "aws-sdk-s3", require: false

gem "puma"

gem "savon", "~> 2.12.0"

gem "fog-aws"
gem "sentry-raven"
gem "sidekiq", "~> 6.5.6"
gem "dalli"

gem "faker", "~> 1.8"
gem "appsignal"

group :development, :test do
  gem "decidim-dev", DECIDIM_VERSION
  gem "dotenv-rails"
  gem "pry-byebug", platform: :mri

  gem "factory_bot_rails"
  gem "rspec-rails"
end

group :development do
  gem "webmock"
  gem "listen", "~> 3.1.0"
  gem "rubocop"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
  gem "letter_opener"
end
