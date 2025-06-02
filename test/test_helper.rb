ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors, with: :threads)
  fixtures :all

  setup do
    ActiveJob::Base.queue_adapter = :test
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end