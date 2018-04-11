# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gem "decidim", "0.10.0"

gem "puma", "~> 3.0"
gem "uglifier", ">= 1.3.0"

gem "savon", "~> 2.12.0"

gem "faker", "~> 1.8.4"

gem "sidekiq"

gem "fog-aws"

gem "sentry-raven"

group :development, :test do
  gem "decidim-dev", "0.10.0"
  gem "dotenv-rails"
  gem "pry-byebug", platform: :mri

  gem "factory_bot_rails"
  gem "rspec-rails"
end

group :development do
  gem "webmock"

  gem "letter_opener_web", "~> 1.3.0"
  gem "listen", "~> 3.1.0"
  gem "rubocop"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
end
