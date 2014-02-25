# environment.rb
# 
# This file is where you should load all of your dependencies and 
# do any global environment setup (e.g. Dotenv.load)

require 'rubygems' 
require 'bundler/setup'
# require all of the gems in the gemfile
Bundler.require
# require any non-gem libraries that are needed
require 'net/https'
require 'erb'
# require all of the app's models
require_all './models'
# set the app root
set :root, File.expand_path("../../", __FILE__)
# load the environment variables from .env (testing environment)
Dotenv.load
# load the config from config.rb
require './app/config'

# Session:Cookie needed by OmniAuth
use Rack::Session::Cookie, :expire_after => 1209600, # 7 days
                           :secret => ENV['COOKIE_SECRET']


# Database provided by sqlite3 in development and postgresql on Heroku
db = URI.parse(ENV['DATABASE_URL'])

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :port     => db.port,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)