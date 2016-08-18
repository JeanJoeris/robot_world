require_relative "../test_helper"

class UserSeesAllRobotsTest < FeatureTest
  def test_user_sees_all_robots
    name = "Hal"
    city = "Where ever I want"
    state = "Anywhere"
    birthday = '2001-01-01'
    hire_date = '2001-01-02'
    department = "Killing humans"
    robot_world.create({
      name: name,
      city: city,
      state: state,
      birthday: birthday,
      hire_date: hire_date,
      department: department,
    })
    robot_world.create({
      name: name + " 2",
      city: city,
      state: state,
      birthday: birthday,
      hire_date: hire_date,
      department: department,
    })

    visit "/robots"

    assert page.has_content?(name)
    assert page.has_content?(name + " 2")
  end

  def test_user_creates_robot_and_sees_it
    name = "Hal"
    city = "Where ever I want"
    state = "Anywhere"
    birthday = '2001-01-01'
    hire_date = '2001-01-02'
    department = "Killing humans"

    visit "/"
    click_link("Join us")
    assert_equal "/robots/new", current_path

    fill_in("Robot name:", :with => name)
    fill_in("Robot city:", :with => city)
    fill_in("Robot state:", :with => state)
    fill_in("Robot birthday:", :with => birthday)
    fill_in("Robot hire date:", :with => hire_date)
    fill_in("Robot department:", :with => department)
    click_button("Prepare to be assimilated!")
    assert_equal "/robots", current_path

    assert page.has_content?(name)
    assert page.has_content?(city)
    assert page.has_content?(department)
  end
end
