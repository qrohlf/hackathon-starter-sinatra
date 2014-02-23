# hackathon-starter-sinatra

This project is a minimalist starter framework intended to be used for small projects when speed of development is a priority. It was created to be used at "Startup Weekend" style events, where a significant portion of your development team may not have experience with Ruby or Rails - and where development time is measured in hours rather than days.

The project focuses on the following goals:
- produce a framework with the dual priorities of speed of development and minimal learning curve
- produce a minimal set of documentation for "how to do X"

# Prerequisites
To run this project locally, you will need a Unix environment like Linux or OSX with the following tools installed:
- [Ruby](https://www.ruby-lang.org/en/) (version 2.0 or newer)
- [Bundler](http://bundler.io)
- [Sqlite](http://www.sqlite.org)

Additionally, if you want to customize stylesheets, you will need a [LESS](http://lesscss.org) compiler like [CodeKit](https://incident57.com/codekit/), [LiveReload](http://livereload.com) or [SimpLess](http://wearekiss.com/simpless).

# Setup
- bundle dependencies with `bundle install --without production`
- if you have older versions of gems installed, you may want to `bundle update`
- rename `.env-example` to `.env` and edit it with your project's API keys and database url.
- run`shotgun` to start the app on your computer
- point your web browser to [http://127.0.0.1:9393/](http://127.0.0.1:9393/) to see the app in action.

# Features
- [Sinatra-ActiveRecord](https://github.com/janko-m/sinatra-activerecord) for database abstraction and Rake tasks
- [Squeel](https://github.com/activerecord-hackery/squeel) for ActiveRecord query awesomeness
- [Bootstrap](http://getbootstrap.com) for dead-easy styling
- Pre-packaged with the [Lumen](http://bootswatch.com/lumen/) [Bootswatch](http://bootswatch.com)  theme
- [OmniAuth](https://github.com/intridea/omniauth) for third-party logins
- [Shotgun](https://github.com/rtomayko/shotgun) for automatically reloading the app after code changes

# Assets

## Styles
This project comes pre-packaged with Bootstrap 3.1.1 and the Lumen theme from [Bootswatch](http://bootswatch.com), but any Bootstrap 4 themes should be drop-in replacements.

Styles are written in LESS. This is because Bootstrap and Bootstrap themes all use LESS. 

## Javascript
The only javascript that this project includes is the bootstrap required javascript in`bootstrap.min.js`.  JQuery 2.1.0 is loaded via Google's Hosted Libraries CDN. The rest is all up to you.

## Pipeline
There is no asset pipeline built into this project. Compile/concat your scripts and styles locally using a tool like [CodeKit](https://incident57.com/codekit/), [LiveReload](http://livereload.com) or [SimpLess](http://wearekiss.com/simpless). Don't forget to commit changes to the compiled scripts and styles!

# Why Sinatra and not Rails?
Rails is a great tool for speeding up development - if your whole team knows Rails. Otherwise, Sinatra is better.

For most hackathon-style micro applications, the full Rails framework introduces too much friction to the development process. It's got a lot of moving parts, a deeply nested directory structure that's difficult for team members without Rails experience to traverse, and a lot of implicit "magic" that can also trip up team members. Sinatra with ActiveRecord gives a lot of the speed benefits of a Rails project without the added complexity of the asset pipeline, sophisticated routing, and other stuff that comes with Rails but isn't that useful in smaller projects.