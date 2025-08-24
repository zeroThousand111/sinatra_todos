require "sinatra"
require "sinatra/reloader"
require "tilt/erubi"

configure do
  enable :sessions
  set :session_secret, SecureRandom.hex(32)
end

before do
  session[:lists] ||= []
end

get "/" do 
  redirect "/lists"
end

# View the list of lists
get "/lists" do
  @lists = session[:lists]
  erb :lists, layout: :layout
end

# Create a new list
post "/lists" do
  session[:lists] << {name: params[:list_name], todos: []}
  redirect "/lists"
end

# Render the new list form
get "/lists/new" do
  erb :new_list, layout: :layout
end
