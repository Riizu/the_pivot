class Seed
  def initialize
    create_style
    create_planets
    create_platform_admin
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

  def create_required_users
    puts "Creating Users"
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

    # 100.times do
    #   name = Faker::StarWars.character
    #   name = name.split
    #   name = name << "Kenobi" if name.count == 1
    #   user = User.new(
    #     first_name:            name.first,
    #     last_name:             name[1..-1].join(" "),
    #     email:                 Faker::Internet.email,
    #     password:              "password",
    #     password_confirmation: "password",
    #     username:              Faker::Internet.user_name,
    #     phone_number:          Faker::Number.number(10)
    #   )
    #   user.orders << add_orders(user.id)
    #   user.save
    # end
    puts "Created Required User"
  end

  def create_user
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
      user
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

  def create_platform_admin
    puts "Creating Platform Admin"
    jorge = User.new(
      first_name:            "Jorge",
      last_name:             "Tellez",
      email:                 "jorge@turing.io",
      password:              "password",
      password_confirmation: "password",
      username:              "jorge",
      role:                   1
    )
    jorge.save

    puts "Created Platform Admin"

  end

  def create_space
    space = Space.create(
      name:            Faker::Book.title + Faker::Hipster.word,
      price:           Faker::Commerce.price,
      style_id:        rand(1..4),
      approved:        true,
      description:     Faker::Hipster.paragraph(3),
      occupancy:       rand(2..50),
    )
    space.users << create_user
    space
  end

  def create_planets
    puts "Creating Planets"
    hoth = Planet.create(
      name: "Hoth"
    )
    puts "Creating hoth spaces"
    50.times do
      hoth.spaces << create_space
    end
    puts "Created hoth spaces"

    tatooine = Planet.create(
      name: "Tatooine"
    )
    puts "Creating tatooine spaces"
    50.times do
      tatooine.spaces << create_space
    end
    puts "Created tatooine spaces"

    coruscant = Planet.create(
      name: "Coruscant"
    )
    puts "Creating coruscant spaces"
    50.times do
      coruscant.spaces << create_space
    end
    puts "Created coruscant spaces"

    20.times do
      planet = Planet.create(
        name: Faker::StarWars.planet
      )
      puts "Creating #{planet.name} spaces"
      50.times do
        planet.spaces << create_space
      end
      puts "Created #{planet.name} spaces"
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
