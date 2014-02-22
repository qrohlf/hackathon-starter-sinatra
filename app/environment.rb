# environment.rb
# 
# This file is where you should load all of your dependencies and 
# do any global environment setup (e.g. Dotenv.load)

require 'rubygems' 
require 'bundler/setup'
# require all of the gems in the gemfile
Bundler.require(:default)
# require any non-gem libraries that are needed
require 'net/https'
require 'erb'
# load the environment variables from .env (testing environment)
Dotenv.load
# load the config from config.yml
config_file './config.yml'