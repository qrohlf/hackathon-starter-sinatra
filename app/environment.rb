# environment.rb
# 
# This file is where you should load all of your dependencies and 
# do any global environment setup (e.g. Dotenv.load)

require 'rubygems' 
require 'bundler/setup'
# require all of the gems in the gemfile
Bundler.require(:default)
# load the environment variables from .env (testing environment)
Dotenv.load