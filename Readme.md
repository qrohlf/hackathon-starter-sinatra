# Hackathon Starter Sinatra

This project is a minimalist starter framework intended to be used for small projects when speed of development is a priority. It was created to be used at "Startup Weekend" style events, where a significant portion of your development team may not have experience with Ruby or Rails - and where development time is measured in hours rather than days. It is licensed under the [MIT License](http://choosealicense.com/licenses/mit/).

The project focuses on the following goals:
- produce a framework optimized for fast development with a minimal learning curve
- produce a set of tutorials for "how to do X" that can be followed by programmers with minimal Ruby experience

# Prerequisites
To run this project locally, you will need a Unix environment like Linux or OSX with the following tools installed:
- [Ruby](https://www.ruby-lang.org/en/) (version 2.0 or newer)
- [Bundler](http://bundler.io)
- [Sqlite](http://www.sqlite.org)

Additionally, if you want to customize stylesheets, you will need a [LESS](http://lesscss.org) compiler. Some good LESS compiler GUIs are [CodeKit](https://incident57.com/codekit/), [LiveReload](http://livereload.com) or [SimpLess](http://wearekiss.com/simpless), or you can use the [official node.js package](http://lesscss.org/#using-less-installation) via the command line.

# Setup
1. download the project
    ```
    git clone git@github.com:qrohlf/hackathon-starter-sinatra.git
    cd hackathon-starter-sinatra
    ```

2. install dependencies
    ```
    bundle install --without production
    ```

3. setup the environment variables
    ```
    mv .env-example .env
    ```

4. setup the database
    ```
    rake db:migrate
    rake db:seed
    ```

5. start the development server
    ```
    shotgun
    ```
6. point your web browser to [http://127.0.0.1:9393/](http://127.0.0.1:9393/) to see the app in action.

# Features
- [Sinatra-ActiveRecord](https://github.com/janko-m/sinatra-activerecord) for database abstraction and Rake tasks
- [Squeel](https://github.com/activerecord-hackery/squeel) for ActiveRecord query awesomeness
- [Bootstrap](http://getbootstrap.com) for dead-easy styling
- Pre-packaged with the [Lumen](http://bootswatch.com/lumen/) [Bootswatch](http://bootswatch.com)  theme
- Include the full [IcoMoon Free](http://icomoon.io/#preview-free) icon font
- [Shotgun](https://github.com/rtomayko/shotgun) for automatically reloading the app after code changes
- [ActiveSupport](http://guides.rubyonrails.org/active_support_core_extensions.html) with all core extensions loaded by default for all the bells and whistles
- [Stripe Checkout](https://stripe.com/docs/checkout) for super-smooth and easy payment processing

# How do I do X?

## X == Add a Model
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

## X == Process Payments

This project provides an easy and robust way to securely process payments through integration with [Stripe Checkout](https://stripe.com/checkout). To use Stripe for payment processing, you'll need an account (sign up [here](https://manage.stripe.com/register)) and a set of API keys. 

To get your stripe API keys, head over to the API keys section of your account settings ([https://manage.stripe.com/account/apikeys](https://manage.stripe.com/account/apikeys)) and copy the secret and publishable keys into the `STRIPE_KEY_SECRET` and `STRIPE_KEY_PUBLIC` of your `.env` file. I suggest copying the testing keys first so that you can make sure everything is working properly, then switch to the development keys when you're ready to deploy.

Your `.env` file should have something like this:

```bash
# Stripe secret key for server-side use
STRIPE_KEY_SECRET='sk_test_ZBLAOTn26WEjvscp0euLTmlB'

# Stripe publishable key for client-side use
STRIPE_KEY_PUBLIC='pk_test_OWXc7nzt4IqPBFsQexpjs4vW'
```
*(these are not actual API keys)*

Next, you'll want to look at the `checkout_button` helper provided in `app.rb`. You can pass this helper an amount (in cents) and an options hash and it will output a fully-functional Stripe checkout button. The following option keys are supported (all values should be strings):

key | value
---|---
:name | What the charge is for
:description | Additional details about the charge
:image | URL for a 128x128 image to display for the charge
:item | A url-safe string to pass to the charge callback

A sample call to the `checkout_button` helper might look like this:

```ruby
checkout_button 500, {name: 'Example Charge Name', description: 'Pretty slick, eh?', item: 'example_charge'}
```

This creates a basic charge button for a $5 fee. When the user completes checkout with Stripe, a POST request will be issued to `/charge/example_charge` with a `stripeToken` parameter that can be used to charge the customer's card. The customer's card *will not* be charged until you explicity do so on the server.

Here is an example implementation of how to actually process the charge in the charge callback (taken straight from `app.rb`):

```ruby
# process a charge for something
# see https://stripe.com/docs/tutorials/charges for details
post '/charge/:item' do 
    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # The cost of your item should probably be stored in your model 
    # or something. Everything is specified in cents
    charge_amounts = {'example_charge' => 500, 'something_else' => 200}; 

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
        charge = Stripe::Charge.create(
            :amount => charge_amounts[params[:item]], # amount in cents. 
            :currency => "usd",
            :card => token,
            :description => "description for this charge" # this shows up in receipts
            )
        title 'Payment Complete'
    rescue Stripe::CardError => e
        title 'Card Declined'
        flash.now[:warning] = 'Your card was declined'
        # The card has been declined
        puts "CardError"
    rescue Stripe::InvalidRequestError => e
        title 'Invalid Request'
        flash.now[:warning] = 'Something went wrong with the transaction. Did you hit refresh? Don\'t do that.'
    rescue => e
        puts e
    end

    haml :charge
end
```

For documentation on Stripe's Ruby API, see [here](https://stripe.com/docs/api?lang=ruby). Also, make sure to update your environment variables on the server when you deploy, since your `.env` file should not be checked in to git.

# Rationale

## Why Sinatra and not Rails?
Rails is a great tool for speeding up development - if your whole team knows Rails. Otherwise, Sinatra is better.

For most hackathon-style micro applications, the full Rails framework introduces too much friction to the development process. It's got a deeply nested directory structure, lots of distracting boilerplate files, and too much implicit "magic" that can also trip up team members. Sinatra with ActiveRecord gives you the convenience of a Rails project with a flatter structure, less boilerplate to wade through, and more explicit code that is easier for people without Rails experience to follow.

## Why no social logins?
Social logins are convenient, but can alienate privacy-minded users and require additional logic to handle the case when a user attempts to log in with multiple services. For the sake of simplicity, this project has opted to use a traditional email/password login system.

If your app needs social permissions, check out the excellent and well-documented [OmniAuth](http://intridea.github.io/omniauth/) project, which includes implementation examples for Sinatra.

## Why no tests?
This is for a hackathon. TDD is great for longer-term projects, but it's unnecessary overhead when time is of the essence and bugs aren't a huge deal.