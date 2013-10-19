source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# User authentication
gem 'devise', '~> 3.0.0.rc'

# Deployment
gem 'capistrano', '~> 2.15'

group :production do
  gem 'mysql2'
  gem 'therubyracer'
end

group :development, :test do
  # For Rails-specific features
  gem 'rspec-rails', '~> 2.14.0'

  # For making factories of test data
  gem 'factory_girl_rails', '~> 4.2.1'

  # better, more useful error pages
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

group :test do
  # generator for fake email addresses, names, etc.
  gem 'faker', '~> 1.1.2'

  # For programming user interactions
  gem 'capybara', '~> 2.1.0'

  # Each spec will run with a clean slate
  gem 'database_cleaner', '~> 1.0.1'

  # Matchers for RSpec to make testing emails go smoothly
  gem 'email_spec'

  # Opens default browser on demand
  gem 'launchy', '~> 2.3.0'

  # Helps test JavaScript-based browser interactions with Capybara
  gem 'selenium-webdriver', '~> 2.35.1'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
