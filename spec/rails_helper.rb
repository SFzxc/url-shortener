# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include RSpec::RequestDescriber, type: :request
  config.include FactoryBot::Syntax::Methods
  config.include RequestHelper, type: :request

  # config.before do
  #   Rack::Attack.reset!
  # end
  config.before :all do
    FactoryBot.reload
  end
  config.before :suite do
    DatabaseRewinder.clean_all
    load Rails.root.join('db', 'seeds.rb')
  end
  config.after :each do
    DatabaseRewinder.clean
  end
end
