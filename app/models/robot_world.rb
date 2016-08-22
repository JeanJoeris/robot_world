class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot_data)
    database.execute("INSERT INTO robots (
        name, city, state, birthday, hire_date, department
      )
      VALUES (?,?,?,?,?,?);",
      robot_data[:name],robot_data[:city],robot_data[:state],
      robot_data[:birthday],robot_data[:hire_date],robot_data[:department]
    )
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(robot_data, id)
    database.execute("UPDATE robots
      SET name = ?, city = ?, state = ?, birthday = ?, hire_date = ?, department = ?
      WHERE id = ?;",
      robot_data[:name],
      robot_data[:city],
      robot_data[:state],
      robot_data[:birthday],
      robot_data[:hire_date],
      robot_data[:department],
      id
    )
  end

  def destroy(id)
    database.execute("DELETE FROM robots WHERE id = ?;", id)
  end

  def delete_all
    database.execute("DELETE FROM robots;")
  end

  def all
    raw_robots.map do |data|
      Robot.new(data)
    end
  end

  def raw_robot(id)
    raw_robots.find { |robot| robot["id"] == id.to_i}
  end

  def raw_robots
    raw_bots = database.execute("SELECT * FROM robots;")
    raw_bots
  end

  def average_age
    total_age = all.reduce(0) do |result, robot|
      result += (Date.today - robot.birthday).abs
      result
    end
    total_age_in_years = total_age/365
    (total_age_in_years/all.count).round(0) if all.count > 0
  end

  def counted_robots_by(grouping)
    grouped_robots = group_robots_by(grouping)
    counted_grouped_robots = grouped_robots.reduce({}) do |result, (grouping_value, robots)|
      result[grouping_value] = robots.count
      result
    end
    counted_grouped_robots.sort_by do |grouping, count|
      grouping
    end
  end

  def group_robots_by(grouping)
    if grouping == "year"
      grouping = "hire_date.year.to_s"
    end
    all.group_by do |robot|
      eval("robot.#{grouping}")
    end
  end
  #
end
