require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'rubygems'
require 'bundler/setup'
require 'rspec/autorun'
require 'open_terms' # and any other gems you need

RSpec.configure do |config|
  # some (optional) config here
  config.mock_with :rspec do |mocks|
    mocks.syntax = [:should, :receive]
  end
end

