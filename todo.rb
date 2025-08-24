require "sinatra"
require "sinatra/reloader"
require "tilt/erubi"

get "/" do 
  redirect "/lists"
end

get "/lists" do
  @lists = [
    {name: "Lunch Groceries", todos: []},
    {name: "Lunch Groceries", todos: []}
  ]
  erb :lists, layout: :layout
end
