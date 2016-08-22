require_relative "../test_helper"

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def current_robot_id
    robot_world.all.last.id
  end

  def get_single_robot_data
    robot_data = {
      name: "Hal",
      city: "Where ever I want",
      state: "Anywhere",
      birthday: '2001-01-01',
      hire_date: '2001-01-02',
      department: "Killing humans"
    }
  end

  def create_two_robots
    names = ["Hal", "Bender"]
    cities = ["Where ever I want", "New New York"]
    states = ["New York", "New York"]
    birthdays = ["2011-08-17", "2006-08-17"]
    hire_dates = ["2016-04-05", "2015-05-06"]
    departments = ["Killing humans", "bending"]
    2.times do |n|
      robot_world.create({
        name: names[n],
        city: cities[n],
        state: states[n],
        birthday: birthdays[n],
        hire_date: hire_dates[n],
        department: departments[n],
      })
    end
  end

  def test_create_a_robot
    robot_world.create(get_single_robot_data)
    robot = robot_world.find(current_robot_id)

    assert_instance_of Robot, robot
  end

  def test_find_a_robot
    robot_data = get_single_robot_data
    robot_world.create(robot_data)
    robot = robot_world.find(current_robot_id)

    assert_equal current_robot_id, robot.id
    assert_equal robot_data[:name], robot.name
    assert_equal robot_data[:city], robot.city
    assert_equal robot_data[:state], robot.state
    assert_equal robot_data[:birthday], robot.birthday.to_s
    assert_equal robot_data[:hire_date], robot.hire_date.to_s
    assert_equal robot_data[:department], robot.department
  end

  def test_finds_all_robots
    2.times do
      robot_world.create(get_single_robot_data)
    end

    assert_equal 2, robot_world.all.count
    assert_instance_of Robot, robot_world.all.last
  end

  def test_delete_a_robot
    robot_world.create(get_single_robot_data)
    robot = robot_world.find(current_robot_id)

    assert_equal 1, robot_world.all.count
    robot_world.destroy(current_robot_id)
    assert_equal 0, robot_world.all.count
  end

  def test_it_updates_a_task
    updated_robot_data = get_single_robot_data
    updated_robot_data[:name] = "Bender"
    updated_robot_data[:department] = "Bending"

    robot_world.create(get_single_robot_data)
    inital_robot_count = robot_world.all.count

    robot_world.update(updated_robot_data, current_robot_id)
    final_robot_count = robot_world.all.count

    updated_robot = robot_world.find(current_robot_id)

    assert_equal inital_robot_count, final_robot_count
    assert_equal "Bender", updated_robot.name
    assert_equal "Bending", updated_robot.department
    assert_equal "Anywhere", updated_robot.state
  end

  def test_average_robot_age
    create_two_robots

    assert_equal 8, robot_world.average_age
  end

  def test_groups_by_department_correctly
    2.times do
      create_two_robots
    end

    data = robot_world.group_robots_by("department")
    assert_equal 2, data["Killing humans"].count
    assert_equal 2, data["bending"].count
  end

  def test_groups_by_city_correctly
    2.times do
      create_two_robots
    end

    data = robot_world.group_robots_by("city")
    assert_equal 2, data["Where ever I want"].count
    assert_equal 2, data["New New York"].count
  end

  def test_groups_by_state_correctly
    2.times do
      create_two_robots
    end

    data = robot_world.group_robots_by("state")
    assert_equal 4, data["New York"].count
  end

  def test_groups_by_hire_year_correctly
    2.times do
      create_two_robots
    end

    data = robot_world.group_robots_by("year")
    assert_equal 2, data["2015"].count
    assert_equal 2, data["2016"].count
  end
end
