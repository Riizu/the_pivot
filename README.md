# Wookie Nights
## Built with Ruby on Rails

### Authors
[Ryan Batty](https://github.com/Riizu), [Jenny Soden](https://github.com/MsJennyGiraffe), [Charles Kaminer](https://github.com/ckaminer),
[Deborah Hamel](https://github.com/deborahleehamel)

This project was created as a part of the curriculum for the [Turing School of Software & Design](http://turing.io).

### Overview

This Rails application is a Star Wars themed lodging site. A user can reserve a space on different planets or add a new space for approval as a host. Users can also add additional users as hosts to any of their spaces. An admin can access and edit all info through and Admin Dashboard as well as manage approvals for new spaces submitted by hosts.

### Live Version

You can find a live version of this application on Heroku at: [https://wookienights.herokuapp.com/](https://wookienights.herokuapp.com/)

### Setup

To set up a local copy of this project, perform the following:

  1. Clone the repository: `git clone https://github.com/Riizu/the_pivot.git`
  2. `cd` into the project's directory
  3. Run `bundle install`
  4. Run `rake db:create db:migrate db:seed` to set up the postgres database and seed it with users, planets, spaces, and climates orders, and categories.
    - If you would like to create your own users, artist, items, and categories do not run `db:seed`
    - The seed file does not include any setup for admins, so those must be created manually by running `rails c` and adding a user to the database with role = 2
  5. Run the application in the dev environment by running `rails s`

### App Features

Some of the main features of the app include:

#### Users

Users can browse the spaces by planet. Each space has a name, description, image, and price associated with it. Users can reserve spaces into their cart. Users do not need to be signed in to browse items but do need to be logged in to reserve a space. A space must be approved by the platform admin before it is available for reservations. Users view any of their past reservations and their listings.

#### Admins

Admins can create and edit spaces. This includes managing each spaces approval status.

#### Other Features

Paperclip and Amazon Web Services S3: Stores and hosts any image uploads.
Twitter: Single Sign On and Social Media integration.
Stripe: Payment.

### Test Suite

The test suite tests the application on multiple levels. To run all of the tests, run `rspec` from the terminal in the main directory of the project. The feature tests rely mainly on the [capybara gem](https://github.com/jnicklas/capybara) for navigating the various application views.

The project also utilizes leverages a bootstrap theme called 'twitter bootstrap'.

### Dependencies

This application depends on many ruby gems, all of which are found in the `Gemfile` and can be installed by running `bundle install` from the terminal in the main directory of the project. The app also relies on Twitter, Stripe, and AWS API keys, which must be provided on a per-site-admin basis.
