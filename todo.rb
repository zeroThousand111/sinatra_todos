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
  list_name = params[:list_name].strip
  if (1..100).cover? list_name.size
    session[:lists] << {name: list_name, todos: []}
    session[:success] = "The list has been created."
    redirect "/lists"
  else
    session[:error] = "List name must be between 1 and 100 characters."
    erb :new_list, layout: :layout
  end
end

# Render the new list form
get "/lists/new" do
  erb :new_list, layout: :layout
end
