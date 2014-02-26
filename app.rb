#######################################
# Routes
# 

before do
    login User.find(session[:user]) if User.exists? session[:user]
end

get '/' do
    erb :landing, layout_engine: :haml
end

get '/examples' do
    title "Examples"
    @examples = Example.all
    haml :examples
end

get '/examples/:id' do
    title @example.name
    @example = Example.find(params[:id])
    haml :example
end

get '/users/new' do
    title 'Sign Up'
    # log out the current user
    logout
    haml :signup
end

post '/users/new' do
    title 'Sign Up'
    user = User.create(params)
    if !user.valid?
        flash.now[:info] = user.errors.map{|attr, msg| "#{attr.to_s.humanize} #{msg}"}.join("<br>")
        haml :signup, locals: {email: params[:email]}
    else 
        login user
        redirect '/'
    end
end

get '/logout' do
    logout
    redirect '/'
end

get '/login' do
    title 'Login'
    haml :login
end

post '/login' do
    title 'Login'
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
        login user
        redirect '/'
    else
        flash.now[:info] = "Sorry, wrong username or password"
        haml :login, locals: {email: params[:email]}
    end
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

    #icomoon icons
    def icon(i)
        "<span class='icon-#{i}'></span>"
    end

    def login(u)
        @user = u
        session[:user] = u.id
    end

    def logout
        @user = nil
        session.clear
    end
end

