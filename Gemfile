# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'faraday', '~> 1.8'
gem 'panolint', '~> 0.1.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 1.1'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'rswag-api', '~> 2.4'
gem 'rswag-specs', '~> 2.4'
gem 'rswag-ui', '~> 2.4'

group :development, :test do
  gem 'factory_bot_rails', '~> 6.2'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 5.0'
  gem 'rubocop-discourse', '~> 2.4'
  gem 'rubocop-rails', '~> 2.12'
  gem 'rubocop-rspec', '~> 2.5'
end

group :test do
  gem 'codacy-coverage', '~> 2.2'
  gem 'database_cleaner', '~> 2.0'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'simplecov-lcov', '~> 0.8.0', require: false
end
