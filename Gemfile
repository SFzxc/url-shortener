source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

gem 'active_model_serializers'
gem 'addressable'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'jwt'
gem 'pg', '~> 1.3.5'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 6.1'
gem 'redis', '~> 4.0'
gem 'hiredis', '~> 0.6.3'
gem 'redis-namespace', '~> 1.9'
gem 'sidekiq', '~> 6.4'
gem 'rack-attack'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-rails'
  gem 'rubocop'
end

group :test do
  gem 'autodoc'
  gem 'brakeman'
  gem 'database_cleaner'
  gem 'database_rewinder'
  gem 'factory_bot'
  gem 'rails-controller-testing'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-rails'
  gem 'rspec-request_describer'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'annotate'
  gem 'capistrano', require: false
  gem 'capistrano3-puma'
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails-collection'
  gem 'capistrano-rails-console', require: false
  gem 'capistrano-rails-tail-log'
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-sidekiq'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
