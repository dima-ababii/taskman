source 'https://rubygems.org'

ruby '2.5.3'

# Ruby on Rails
gem 'rails', '5.2'

# Use PostgreSQL as the database for Active Record
gem 'pg'

# App server
gem 'puma'

# Admin panel
gem 'activeadmin'

# Use Devise for AdminUser authentication
gem 'devise'

# Authorization
gem 'cancancan'

# Attributes encryption (be carefull with updates)
gem 'attr_encrypted', '3.1.0'

# Pagination for ActiveRecord
gem 'kaminari'

# CSS
gem 'bootstrap'
# gem 'bootstrap-sass'

# JavaScript
gem 'jquery-rails' # main JS library
gem 'jquery-ui-rails' # jQuery UI
gem 'uglifier' # compressor
gem 'typedjq-rails' # typewriter based on JQuery library
gem 'chosen-rails' # Form selecter

# HTML template engine
gem 'slim-rails'
# File uploading
gem 'carrierwave'
# File validators
gem 'file_validators'

# Use ActiveModel has_secure_password
gem 'bcrypt'

# ENV variables
gem 'figaro'

# Meta Tags
gem 'meta-tags'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen'
  
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
  
  # Mailer
  gem 'letter_opener'
end

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  # Fixtures replacement
  gem 'factory_bot_rails'
  # Fake data generator for FactoryGirl
  gem 'faker'
  # RSpec single line tests
end

group :test do
  gem 'shoulda-matchers'
  # Template matcher
  gem 'rails-controller-testing'
  # Express expected outcomes for RSpec tests
  gem 'rspec-expectations'
end
