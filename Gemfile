ruby "2.1.1"
source 'https://rubygems.org'
gem 'sinatra'
gem 'haml'
gem 'sinatra-contrib', require: 'sinatra/config_file'           
gem "activerecord"
gem "sinatra-activerecord", require: 'sinatra/activerecord'
gem 'tux'
gem 'rake'
gem 'dotenv'
gem 'squeel'
gem 'json'
gem 'require_all'
gem 'activesupport', require: ['active_support', 'active_support/core_ext']
gem 'rack-flash3', require: 'rack-flash'
gem "sinatra-flash", require: 'sinatra/flash'
gem 'bcrypt'
gem 'bcrypt-ruby' #legacy
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'redcarpet', require: 'redcarpet/compat' #markdown rendering
gem 'mail'
gem 'premailer' #for inlining email styles
gem 'nokogiri' #premailer wants this

group :development do
    gem "sqlite3"
    gem "shotgun"
end

group :production do 
    gem "pg"                        # Needed for postgresql on Heroku
end