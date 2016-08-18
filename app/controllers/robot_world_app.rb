class RobotWorldApp < Sinatra::Base

  get '/' do
    @average_age = robot_world.average_age
    @robots_by_city = robot_world.counted_robots_by(:city)
    @robots_by_state = robot_world.counted_robots_by(:state)
    @robots_by_department = robot_world.counted_robots_by(:department)
    @robots_by_year = robot_world.counted_robots_by(:year)
    erb :dashboard
  end

  get '/robots' do
    @robots = robot_world.all
    erb :index
  end

  post '/robots' do
    robot_world.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/new' do
    erb :new
  end

  get '/robots/:id' do
    @robot = robot_world.find(params[:id])
    erb :show
  end

  put '/robots/:id' do
    robot_world.update(params[:robot], params[:id])
    redirect "/robots/#{params[:id]}"
  end

  get '/robots/:id/edit' do
    @robot = robot_world.find(params[:id])
    erb :edit
  end

  delete '/robots/:id' do
    robot_world.destroy(params[:id])
    redirect '/robots'
  end

  def robot_world
    if ENV["RACK_ENV"] == "test"
      database = YAML::Store.new('db/robot_world_test')
    else
      database = YAML::Store.new('db/robot_world')
    end
    @robot_world ||= RobotWorld.new(database)
  end

end
