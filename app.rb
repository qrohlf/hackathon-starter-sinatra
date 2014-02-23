require './app/environment'

set :root, File.dirname(__FILE__)

get '/' do
    erb :landing, layout_engine: :haml
end

get '/examples' do
    @examples = Example.all
    haml :"examples/examples"
end

get '/examples/:id' do
    @example = Example.find(params[:id])
    haml :"examples/example"
end