require_relative "spec_helper"
require_relative "../app"
# Exit if the environment is not set.
exit unless ENV["RACK_ENV"] == "test"

require "database_cleaner/active_record"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
