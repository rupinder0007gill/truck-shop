# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

# Loads environment variables from `.env`.
# Read more: https://github.com/bkeepers/dotenv
gem 'dotenv', '~> 2.8', '>= 2.8.1', require: './config/dotenv'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Unobtrusive nested forms handling, using jQuery. Use this and discover cocoon-heaven.
# Read more: https://github.com/nathanvda/cocoon
gem 'cocoon', '~> 1.2', '>= 1.2.15'

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
# Read more: https://github.com/rails/cssbundling-rails
gem 'cssbundling-rails'

# Flexible authentication solution for Rails with Warden
# Read more: https://github.com/heartcombo/devise
gem 'devise', '~> 4.9', '>= 4.9.3'

# Translations for the devise gem
# https://github.com/tigrish/devise-i18n
gem 'devise-i18n', '~> 1.12'

# It adds support for send invitations by email (it requires to be authenticated) and accept the invitation by setting a password.
# https://github.com/scambra/devise_invitable
gem 'devise_invitable', '~> 2.0', '>= 2.0.9'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# Read more: https://github.com/janko/image_processing
gem 'image_processing', '~> 1.12', '>= 1.12.2'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11', '>= 2.11.5'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
# Read more: https://github.com/rails/jsbundling-rails
gem 'jsbundling-rails', '~> 1.2', '>= 1.2.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Paranoia is a re-implementation of acts_as_paranoid for Rails 5, 6, and 7, using much, much, much less code. You would use either plugin / gem if you wished that when you called destroy on an Active Record object that it didn't actually destroy it, but just "hid" the record. Paranoia does this by setting a deleted_at field to the current time when you destroy a record, and hides it by scoping all queries on your model to only include records which do not have a deleted_at field.
# Read more: https://github.com/rubysherpas/paranoia
gem 'paranoia', '~> 2.6', '>= 2.6.3'

# Agnostic pagination in plain ruby. It does it all. Better.
# Read more: https://github.com/ddnexus/pagy
gem 'pagy', '~> 8.0', '>= 8.0.2'

# Use postgresql as the database for Active Record
# Read more: https://github.com/ged/ruby-pg
gem 'pg', '~> 1.5', '>= 1.5.6'

# PgSearch builds Active Record named scopes that take advantage of PostgreSQL's full text search
# Read more: https://github.com/Casecommons/pg_search
gem 'pg_search', '~> 2.3', '>= 2.3.6'

# Use the Puma web server [https://github.com/puma/puma]
# Read more: https://github.com/puma/puma/
gem 'puma', '~> 6.4', '>= 6.4.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

# Helpers for the reCAPTCHA API
# Read more: https://github.com/ambethia/recaptcha
gem 'recaptcha', '~> 5.16'

# Use Redis adapter to run Action Cable in production
# Read more: https://github.com/redis/redis-rb
gem 'redis', '~> 5.1'

# ruby-vips is a binding for the libvips image processing library. It is fast and it can process large images without loading the whole image in memory.
# Read more: https://github.com/libvips/ruby-vips
gem 'ruby-vips', '~> 2.2', '>= 2.2.1'

# Official Twilio SendGrid Gem to Interact with Twilio SendGrids API in native Ruby
# Read more: https://github.com/sendgrid/sendgrid-ruby
gem 'sendgrid-ruby', '~> 6.7'

# Simple, efficient background processing for Ruby.
# Read more: https://sidekiq.org/
gem 'sidekiq', '~> 7.2', '>= 7.2.2'

# Enables to set jobs to be run in specified time (using CRON notation or natural language)
# Read more: https://github.com/sidekiq-cron/sidekiq-cron
gem 'sidekiq-cron', '~> 1.12'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
# Read more: https://github.com/rails/sprockets-rails
gem 'sprockets-rails', '~> 3.4', '>= 3.4.2'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
# Read more: https://stimulus.hotwired.dev/
gem 'stimulus-rails', '~> 1.3', '>= 1.3.3'

# Truncates html so you don't have to
# Read more: https://github.com/countries/country_select
gem 'truncate_html', '~> 0.9.3'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
# Read more: https://github.com/hotwired/turbo-rails
gem 'turbo-rails', '~> 2.0', '>= 2.0.5'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  # help to kill N+1 queries and unused eager loading
  # Read more: https://github.com/flyerhzm/bullet
  gem 'bullet', '~> 7.1', '>= 7.1.6'
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
end

group :development do
  gem 'annotate', '~> 3.2'
  gem 'foreman'
  gem 'guard-rspec', require: false
  gem 'listen', '~> 3.8'
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Automatic Ruby code style checking tool
  # Read more: https://docs.rubocop.org/
  gem 'rubocop', '~> 1.62', '>= 1.62.1', require: false
  gem 'rubocop-performance', '~> 1.21', require: false
  gem 'rubocop-rails', '~> 2.24', '>= 2.24.1'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end
