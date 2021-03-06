ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"

  add_group "Models",      "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Workers",     "app/workers"
  add_group "Lib",         "lib"
end

require 'sinatra'
require 'rack/test'
require 'fabrication'
require 'database_cleaner'

require './application'

module ApiHelper
  def json_response
    JSON.parse(last_response.body)
  end

  def json_error
    json_response['error']
  end
end

Fabrication.configure do |config|
  config.fabricator_path = 'spec/fabricators'
  config.path_prefix     = '.'
  config.sequence_start  = 10000
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include ApiHelper

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Redis.current.flushall
  end
end

def app
  Reeder::Application
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end
