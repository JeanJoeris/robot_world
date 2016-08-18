require_relative "../test_helper"

class UserSeesDashboardStats < FeatureTest

  def setup
    names = ["Hal", "Bender"]
    cities = ["Where ever I want", "New New York"]
    states = ["Anywhere", "New York"]
    birthdays = ["2011-08-17", "2006-08-17"]
    hire_dates = ["2016-04-05", "2016-05-06"]
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

  def test_user_sees_average_age
    visit "/"
    assert page.has_content?("Average Age: 8")
  end

  def test_user_sees_table_headers
    visit "/"
    assert page.has_content?("Department Robot Count")
    assert page.has_content?("City Robot Count")
    assert page.has_content?("State Robot Count")
    assert page.has_content?("Year Robot Count")
  end

  def test_user_sees_correct_counts
    visit "/"
    assert page.has_content?("New New York 1")
    assert page.has_content?("Killing humans 1")
    assert page.has_content?("2016 2")
  end
end
