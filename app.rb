# fdezhfzue
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'

require_relative 'cookbook'
require_relative 'recipe'

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  csv_file = File.join(__dir__, 'recipes.csv')
  @recipes = Cookbook.new(csv_file)
  @titles = []
  @recipes.all.each { |recipe| @titles << recipe.name }
  erb :index
end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end

get '/new' do
  erb :form
end

post '/create' do
  csv_file = File.join(__dir__, 'recipes.csv')
  @recipes = Cookbook.new(csv_file)
  recipe = Recipe.new({ name: params[:name], description: params[:description] })
  @recipes.add_recipe(recipe)
  @titles = []
  @recipes.all.each { |recip| @titles << recip.name }
  erb :index
end

get '/destroy/:index' do
  index = params[:index].to_i
  csv_file = File.join(__dir__, 'recipes.csv')
  @recipes = Cookbook.new(csv_file)
  @recipes.remove_recipe(index)
  @titles = []
  @recipes.all.each { |recip| @titles << recip.name }
  erb :index
end

get '/read/:index' do

end
