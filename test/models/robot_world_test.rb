require_relative "../test_helper"

class RobotWorldTest < Minitest::Test
  include TestHelpers
  def test_create_a_robot_and_find_it
    robot_data = {
      id: 1,
      name: "Hal",
      city: "Where ever I want",
      state: "Anywhere",
      birthday: '2001-01-01',
      hire_date: '2001-01-02',
      department: "Killing humans",
    }
    robot_world.create(robot_data)
    robot = robot_world.find(robot_data[:id])

    assert_equal robot_data[:id], robot.id
    assert_equal robot_data[:name], robot.name
    assert_equal robot_data[:city], robot.city
    assert_equal robot_data[:state], robot.state
    assert_equal robot_data[:birthday], robot.birthday.to_s
    assert_equal robot_data[:hire_date], robot.hire_date.to_s
    assert_equal robot_data[:department], robot.department
  end

  def test_delete_a_robot
    robot_data = {
      id: 1,
      name: "Hal",
      city: "Where ever I want",
      state: "Anywhere",
      birthday: '2001-01-01',
      hire_date: '2001-01-02',
      department: "Killing humans",
    }
    robot_world.create(robot_data)
    robot = robot_world.find(robot_data[:id])

    assert_equal 1, robot_world.all.count
    robot_world.destroy(robot_data[:id])
    assert_equal 0, robot_world.all.count
  end
end
