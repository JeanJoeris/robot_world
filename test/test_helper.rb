ENV["RACK_ENV"] = "test"

require 'minitest/autorun'
require 'minitest/pride'
require File.expand_path("../../config/environment", __FILE__)
require 'capybara/dsl'

module TestHelpers
  def teardown
    robot_world.delete_all
    super
  end

  def robot_world
    database = YAML::Store.new('db/robot_world_test')
    @robot_world ||= RobotWorld.new(database)
  end
end

Capybara.app = RobotWorldApp

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end


# ENV["RACK_ENV"] = "test"
#
# require 'minitest/autorun'
# require 'minitest/pride'
# require File.expand_path("../../config/environment", __FILE__)
# require 'capybara/dsl'
# module TestHelpers
#   def teardown
#     task_manager.delete_all
#     # `mv *.html capybara_screenshots`
#     super
#   end
#
#   def task_manager
#     database = YAML::Store.new('db/task_manager_test')
#     @task_manager ||= TaskManager.new(database)
#   end
# end
#
# Capybara.app = TaskManagerApp
#
# class FeatureTest < Minitest::Test
#   include Capybara::DSL
#   include TestHelpers
# end
