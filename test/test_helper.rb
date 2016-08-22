ENV["RACK_ENV"] = "test"

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'

module TestHelpers
  def teardown
    robot_world.delete_all
    super
  end

  def robot_world
    database = SQLite3::Database.new('db/robot_world_test.db')
    database.results_as_hash = true
    @robot_world ||= RobotWorld.new(database)
  end
end

Capybara.app = RobotWorldApp

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
