# hackathon-starter-sinatra

This project is a minimalist starter framework intended to be used for small projects when speed of development is a priority. It was created to be used at "Startup Weekend" style events, where a significant portion of your development team may not have experience with ruby or Rails and where development time is measured in hours rather than days.

The project focuses on the following goals:
- produce a framework with the dual priorities of speed of development and minimal learning curve
- produce a minimal set of documentation for "how to do X"

# Setup
- `bundle install --without production`
- `bundle update`
- copy `.env-example` to `.env` and fill in the blanks

# Assets

## Styles
This project comes pre-packaged with Bootstrap 3.1.1 and the Lumen theme from [Bootswatch](http://bootswatch.com), but any Bootstrap 4 themes should be drop-in replacements.

Styles are written in LESS. This is because Bootstrap and Bootstrap themes all use LESS. 

## JS
The only js that this project comes with is the full bootstrap shebang in`bootstrap.min.js`.  The rest is up to you.

## Pipeline
There is no asset pipeline built into this project. Compile/concat your scripts and files locally using a tool like [CodeKit](https://incident57.com/codekit/) or [grunt](http://gruntjs.com) or [SimpLess](http://wearekiss.com/simpless).

# Rationale

## Sinatra
For most hackathon-style micro applications, the full Rails framework introduces too much friction to the development process. It's got a lot of moving parts, a deeply nested directory structure that's difficult for team members with less Rails experience to grasp, and a lot of implicit "magic" that can also trip up team members. Sinatra with ActiveRecord gives a lot of the speed benefits of a Rails project without the added complexity of the asset pipeline, sophisticated routing, and other stuff that comes with Rails but isn't that useful in smaller projects.