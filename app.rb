require './app/environment'

set :root, File.dirname(__FILE__)

get '/' do
  erb :landing, layout_engine: :haml
end