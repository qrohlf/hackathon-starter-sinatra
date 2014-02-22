ruby "2.0.0"
source 'https://rubygems.org'
gem 'sinatra'
gem 'haml'
gem 'sinatra-contrib', require: 'sinatra/config_file'           
gem "activerecord"
gem "sinatra-activerecord", require: 'sinatra/activerecord'
gem "omniauth"
gem "omniauth-google-oauth2"
gem 'tux'
gem 'rake'
gem 'dotenv'
gem 'squeel'
gem 'json'

group :development do
    gem "sqlite3"
    gem "shotgun"
end

group :production do 
    gem "pg"                        # Needed for postgresql on Heroku
end