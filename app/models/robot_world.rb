require 'yaml/store'
require_relative 'robot'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot_data)
    database.transaction do
      database['total'] ||= 0
      database['total'] += 1
      database["robots"] ||= []
      database["robots"] << {
        :id         => database["total"],
        :name       => robot_data[:name],
        :city       => robot_data[:city],
        :state      => robot_data[:state],
        :birthday   => robot_data[:birthday],
        :hire_date  => robot_data[:hire_date],
        :department => robot_data[:department]
      }
    end
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(robot_data, id)
    database.transaction do
      robot = database["robots"].find { |data| data[:id] == id.to_i}
      robot[:name] = robot_data[:name]
      robot[:city] = robot_data[:city]
      robot[:state] = robot_data[:state]
      robot[:birthday] = robot_data[:birthday]
      robot[:hire_date] = robot_data[:hire_date]
      robot[:department] = robot_data[:department]
    end
  end

  def destroy(id)
    database.transaction do
      database["robots"].delete_if { |data| data[:id] == id.to_i }
    end
  end

  def all
    raw_robots.map { |data| Robot.new(data) }
  end

  def average_age
    database.transaction do
      total_age = database["robots"].reduce(0) do |result, robot|
        robot = Robot.new(robot)
        result += (Date.today - robot.birthday)
        result
      end
      number_of_robots = database["robots"].count
      (total_age/number_of_robots).to_i/365
    end
  end

  def group_robots_by(grouping_parameter)
    database.transaction do
      database["robots"].group_by do |robot|
        robot[grouping_parameter]
      end
    end
  end

  def group_robots_by_hiring_year
    database.transaction do
      database["robots"].group_by do |robot|
        Robot.new(robot).hire_date.year
      end
    end
  end

  def raw_robot(id)
    raw_robots.find { |robot| robot[:id] == id.to_i}
  end

  def raw_robots
    database.transaction do
      database["robots"] || []
    end
  end
end
