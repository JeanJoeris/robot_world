class RobotWorldApp < Sinatra::Base

  get '/' do
    @average_age = robot_world.average_age
    @robots_by_city = robot_world.counted_robots_by("city")
    @robots_by_state = robot_world.counted_robots_by("state")
    @robots_by_department = robot_world.counted_robots_by("department")
    @robots_by_year = robot_world.counted_robots_by("year")
    haml :dashboard
  end

  get '/robots' do
    @robots = robot_world.all
    haml :index
  end

  post '/robots' do
    robot_world.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/new' do
    haml :new
  end

  get '/robots/:id' do
    @robot = robot_world.find(params[:id])
    haml :show
  end

  put '/robots/:id' do
    robot_world.update(params[:robot], params[:id])
    redirect "/robots/#{params[:id]}"
  end

  get '/robots/:id/edit' do
    @robot = robot_world.find(params[:id])
    haml :edit
  end

  delete '/robots/:id' do
    robot_world.destroy(params[:id])
    redirect '/robots'
  end

  get '*' do
    haml :not_found
  end

  def robot_world
    if ENV["RACK_ENV"] == "test"
      database = SQLite3::Database.new('db/robot_world_test.db')
    else
      database = SQLite3::Database.new('db/robot_world_development.db')
    end
    database.results_as_hash = true
    @robot_world ||= RobotWorld.new(database)
  end

end
