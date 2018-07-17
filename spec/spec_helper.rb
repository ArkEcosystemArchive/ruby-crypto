require 'codecov'
SimpleCov.start

require 'simplecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

require 'arkecosystem/crypto'
require 'btcruby'
require 'bundler/setup'
require 'ostruct'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  # config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
