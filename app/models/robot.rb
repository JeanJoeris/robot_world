class Robot
  attr_reader :id,
              :name,
              :city,
              :state,
              :birthday,
              :hire_date,
              :department

  def initialize(robot_data)
    @id         = robot_data[:id]
    @name       = robot_data[:name]
    @city       = robot_data[:city]
    @state      = robot_data[:state]
    @birthday   = format_time(robot_data[:birthday])
    @hire_date  = format_time(robot_data[:hire_date])
    @department = robot_data[:department]
  end

  def format_time(time_string)
    if time_string.include?("/")
      Date.strptime(time_string, "%m/%d/%Y")
    else
      Date.strptime(time_string, "%Y-%m-%d")
    end
  end
end
