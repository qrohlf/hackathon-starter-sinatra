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
- create the database and examples table with `rake db:migrate`
- seed the database with testing data with `rake db:seed`
- run `shotgun` to start the app on your computer
- point your web browser to [http://127.0.0.1:9393/](http://127.0.0.1:9393/) to see the app in action.

# Features
- [Sinatra-ActiveRecord](https://github.com/janko-m/sinatra-activerecord) for database abstraction and Rake tasks
- [Squeel](https://github.com/activerecord-hackery/squeel) for ActiveRecord query awesomeness
- [Bootstrap](http://getbootstrap.com) for dead-easy styling
- Pre-packaged with the [Lumen](http://bootswatch.com/lumen/) [Bootswatch](http://bootswatch.com)  theme
- [OmniAuth](https://github.com/intridea/omniauth) for third-party logins
- [Shotgun](https://github.com/rtomayko/shotgun) for automatically reloading the app after code changes
- [ActiveSupport](http://guides.rubyonrails.org/active_support_core_extensions.html) with all core extensions loaded by default for all the bells and whistles

# How do I do X?

## X == add a model
If you're not familiar with ActiveRecord and  ActiveRecord database migrations, follow this guide to create a new model for your application (replace 'example' with the name of your model, making sure to adjust for pluralization and capitalization).

First, create the database table where the model's data will be stored:
```bash
rake db:create_migration NAME=create_examples
```
*Note that "examples" is plural. In ActiveRecord, the convention is that database table names are expected to be plural, while class names are singular. For more on this, see [here](http://edgeguides.rubyonrails.org/active_record_basics.html#naming-conventions).*

Now look in your `db/migrate` directory. There should be a new file with your migration there. (It will be named something like `20140223171803_create_examples.rb`). Open it and add your model details (documentation on how to write ActiveRecord migrations is available [here](http://edgeguides.rubyonrails.org/migrations.html)).

My database migration looks like this:
```ruby
class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
        t.string :name
        t.text :description

        t.timestamps
    end
  end
end
```

Now you need to create your model class. Create a new file in `models/` called `Example.rb` (note that the class name is singular and captialized). Open it and declare a subclass of `ActiveRecord::Base` like so:
```ruby
class Example < ActiveRecord::Base
end
```

That's all the code you need. (For documentation on some fancier things you can do with ActiveRecord like validations and associations, see [this guide](http://edgeguides.rubyonrails.org/active_record_basics.html)).

Now, open a terminal and run your database migration:
```bash
rake db:migrate
```
This will create a table in your database called `examples` with the columns `name`, `description`, `created_at`, and `updated_at` . It will also update `db/schema.rb` with your app's updated database schema.

You can now create, read, update, and delete instances of your new model within your app. For example, 
```ruby
Example.create(name: 'foo', description: 'bar')
```
will create a new `Example` class and add it to the `examples` database.

# Rationale

## Why Sinatra and not Rails?
Rails is a great tool for speeding up development - if your whole team knows Rails. Otherwise, Sinatra is better.

For most hackathon-style micro applications, the full Rails framework introduces too much friction to the development process. It's got a deeply nested directory structure, lots of distracting boilerplate files, and a lot of implicit "magic" that can also trip up team members. Sinatra with ActiveRecord gives a lot of the convenience of a Rails project with a flatter structure, less boilerplate to wade through, and more explicit code that is easier for people without Rails experience to follow..

## Why no tests?
This is for a hackathon. TDD is great for longer-term projects, but it's unnecessary overhead when time is of the essence and bugs aren't a huge deal.