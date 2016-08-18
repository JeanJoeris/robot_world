require 'bundler'
Bundler.require

APP_ROOT = File.expand_path("..", __dir__)

# Load all controllers
Dir.glob(File.join(APP_ROOT, "app", "controllers", "*.rb")).each do |file|
  require file
end

# Load all models
Dir.glob(File.join(APP_ROOT, "app", "models", "*.rb")).each do |file|
  require file
end

class RobotWorldApp < Sinatra::Base
  set :root, APP_ROOT
  set :views, File.join(APP_ROOT, "app", "views")
  set :public_folder, File.join(APP_ROOT, "app", "public")
  set :method_override, true
end
