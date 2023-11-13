# frozen_string_literal: true

DECIDIM_VERSION = { git: 'https://github.com/decidim/decidim', branch: 'develop' }.freeze

source "https://rubygems.org"

ruby "3.1.1"

gem "decidim", DECIDIM_VERSION

gem "pg"
gem "aws-sdk-s3", require: false

gem "puma"

gem "savon", "~> 2.12.0"

gem "fog-aws"
gem "sentry-raven"
gem "sidekiq", "~> 6.5.6"
gem "dalli"

gem "faker", "~> 3.2"
gem "appsignal"

gem "progressbar"
gem "seven_zip_ruby"

group :development, :test do
  gem "decidim-dev", DECIDIM_VERSION
  gem "dotenv-rails"
  gem "pry-byebug", platform: :mri

  gem "factory_bot_rails"
  gem "rspec-rails"
end

group :development do
  gem "webmock"
  gem "listen", "~> 3.8.0"
  gem "rubocop"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
  gem "letter_opener"
end
