
require 'sqlite3'

database = SQLite3::Database.new("db/robot_world_development.db")

#Delete existing records from the tasks table before inserting these new records; we'll start from scratch.
database.execute("DELETE FROM robots")

# Insert records.
database.execute("INSERT INTO robots
  (name, city, state, birthday, hire_date, department)
  VALUES
    ('Hal', 'Where ever I want', 'Anywhere', '2001-01-01', '2001-01-02', 'Killing humans'),
    ('C3P0', 'Mos Eisley', 'Tatooine', '1900-04-28','2016-01-01', 'Translation'),
    ('R2D2', 'Mos Eisley', '??', '02/05/1965', '06/08/2001', 'Astromech'),
    ('Steve', 'Fort Collins', 'Colorado', '08/29/1980', '05/16/2004', 'Being useless');"
  )

# verifying that our SQL INSERT statement worked
puts "It worked and:"
p database.execute("SELECT * FROM robots;")
