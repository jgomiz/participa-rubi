# frozen_string_literal: true

DECIDIM_VERSION = "0.23.6"

source "https://rubygems.org"

ruby "2.6.6"

gem "decidim", DECIDIM_VERSION

gem "puma"
gem "uglifier", ">= 1.3.0"

gem "savon", "~> 2.12.0"

gem "fog-aws"
gem "sentry-raven"
gem "sidekiq"

gem "faker", "~> 1.8"

gem "letter_opener_web", "~> 1.3.0"

# The sprockets 4.0.0 version fails with Decidim 0.18.1 assets.
gem "sprockets", "3.7.2"

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
  gem "xray-rails"
end
