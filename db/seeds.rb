class Seed
  def initialize
    create_style
    create_users
    create_planets
    create_business_owners
    create_spaces
  end

  def add_orders(user_id)
    orders = []
    10.times do
      order = Order.new(
        user_id: user_id,
        status:  "completed"
      )
      orders << order
    end
    orders
  end

  def create_users
    puts "Creating Users"
    josh = User.new(
      first_name:            "Josh",
      last_name:             "Mejia",
      email:                 "jmejia@turing.io",
      password:              "password",
      password_confirmation: "password",
      username:              "jmejia@turing.io"
    )
    josh.orders << add_orders(josh.id)
    josh.save

    80.times do
      name = Faker::StarWars.character
      name = name.split
      name = name << "Kenobi" if name.count == 1
      user = User.new(
        first_name:            name.first,
        last_name:             name[1..-1].join(" "),
        email:                 Faker::Internet.email,
        password:              "password",
        password_confirmation: "password",
        username:              Faker::Internet.user_name,
        phone_number:          Faker::Number.number(10)
      )
      user.orders << add_orders(user.id)
      user.save
    end
    puts "Created User"
  end

  def create_business_owners
    puts "Creating Business Owners"
    nate = User.new(
      first_name:            "Nate",
      last_name:             "Allen",
      email:                 "nate@turing.io",
      password:              "password",
      password_confirmation: "password",
      username:              "nate@turing.io"
    )
    nate.spaces << create_space
    nate.orders << add_orders(nate.id)
    nate.save

    20.times do
      name = Faker::StarWars.character
      name = name.split
      name = name << "Kenobi" if name.count == 1
      user = User.new(
        first_name:            name.first,
        last_name:             name[1..-1].join(" "),
        email:                 Faker::Internet.email,
        password:              "password",
        password_confirmation: "password",
        username:              Faker::Internet.user_name,
        phone_number:          Faker::Number.number(10)
      )
      user.spaces << create_space
      user.orders << add_orders(user.id)
      user.save
    end
    puts "Created Business Owners"
  end

  def create_space
    Space.new(
      name:            Faker::Book.title,
      price:           Faker::Commerce.price,
      style_id:        rand(1..4),
      planet_id:       rand(1..10),
      approved:        true,
      description:     Faker::Hipster.sentence,
      occupancy:       rand(2..50)
    )
  end

  def create_spaces
    puts "Creating Spaces"
    480.times do
      space = Space.new(
        name:            Faker::Book.title + Faker::Hipster.words(2).join(" "),
        price:           Faker::Commerce.price,
        style_id:        rand(1..4),
        planet_id:       rand(1..10),
        approved:        true,
        description:     Faker::Hipster.sentence,
        occupancy:       rand(2..50)
      )
      user = User.find(rand(2..20))
      user.password = "password"
      user.save
      space.users << user
      space.save
    end
    puts "Created Spaces"
  end

  def create_planets
    puts "Creating Planets"
    Planet.create(
      name: "Hoth"
    )
    Planet.create(
      name: "Tatooine"
    )
    Planet.create(
      name: "Coruscant"
    )
    15.times do
      Planet.create(
        name: Faker::StarWars.planet
      )
    end
    puts "Created Planets"
  end

  def create_style
    puts "Creating Styles"
    styles = ["Hot", "Cold", "Dry", "Tropical"]
    styles.each do |style|
      Style.create(
      name: style
      )
    end
    puts "Created Styles"
  end
end

Seed.new
