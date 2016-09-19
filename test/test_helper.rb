ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails"
require 'webmock/minitest'
require 'mocha/mini_test'


class ActiveSupport::TestCase
  include Rails::Controller::Testing::TestProcess
  include Rails::Controller::Testing::TemplateAssertions
  include Rails::Controller::Testing::Integration
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  before do
    WebMock.disable_net_connect! :allow_localhost => true
  end
  # Add more helper methods to be used by all tests here...
end
