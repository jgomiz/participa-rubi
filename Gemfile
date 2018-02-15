# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gem "decidim", "0.9.2"

# Uncomment the following line if you want to use decidim-assemblies plugin
# gem "decidim-assemblies", "0.8.3"

gem "puma", "~> 3.0"
gem "uglifier", ">= 1.3.0"

gem "faker", "~> 1.8.4"

gem "sidekiq"

gem "fog-aws"

group :development, :test do
  gem "pry-byebug", platform: :mri
  gem "decidim-dev", "0.9.2"
end

group :development do
  gem "letter_opener_web", "~> 1.3.0"
  gem "listen", "~> 3.1.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
end
