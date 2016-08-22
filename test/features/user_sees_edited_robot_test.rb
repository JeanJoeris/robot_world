require_relative "../test_helper"

class UserSeesEditedRobotTest < FeatureTest

  def current_robot_id
    robot_world.all.last.id
  end

  def test_user_edits_robot_and_sees_it
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

    visit "/robots"
    within(".jumbotron") do
      assert page.has_content?("Name: Hal")
    end

    visit "/robots/#{current_robot_id}/edit"
    fill_in("Robot name:", :with => "Bender")
    click_button("My changes are complete")

    assert_equal "/robots/#{current_robot_id}", current_path
    within(".jumbotron") do
      assert page.has_content?("Name: Bender")
    end
  end
end
