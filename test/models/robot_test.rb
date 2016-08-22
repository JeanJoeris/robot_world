require_relative "../test_helper"

class RobotTest < Minitest::Test
  def test_robots_have_properties
    robot_data = {
      "id" => 1,
      "name" => "Hal",
      "city" => "Where ever I want",
      "state" => "Anywhere",
      "birthday" => '2001-01-01',
      "hire_date" => '2001-01-02',
      "department" => "Killing humans",
    }
    test_robot = Robot.new(robot_data)
    assert_equal 1, test_robot.id
    assert_equal "Hal", test_robot.name
    assert_equal "Where ever I want", test_robot.city
    assert_equal "Anywhere", test_robot.state
    assert_equal "2001-01-01", test_robot.birthday.to_s
    assert_equal "2001-01-02", test_robot.hire_date.to_s
    assert_equal "Killing humans", test_robot.department
  end
end
