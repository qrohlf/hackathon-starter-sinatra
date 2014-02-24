#######################################
# Routes
# 

get '/' do
    erb :landing, layout_engine: :haml
end

get '/examples' do
    title "Examples"
    @examples = Example.all
    haml :examples
end

get '/examples/:id' do
    @example = Example.find(params[:id])
    title @example.name
    haml :example
end

#######################################
# Helpers

helpers do 
    # set the page title
    def title(t)
        @title = "#{t} | #{settings.app_name}"
    end

    # bootstrap glyphicons
    def glyph(i)
        "<span class='glyphicon glyphicon-#{i}'></span>"
    end
end