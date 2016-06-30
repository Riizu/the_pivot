user_1 = User.create(username: "test", password: "password", email: "email@example.com", first_name: "John", last_name: "Doe", phone_number: "123-456-7890")
user_2 = User.create(username: "test2", password: "password", email: "email2@example.com", first_name: "Jane", last_name: "Doe", phone_number: "123-456-7890")

hoth = Planet.create(name: "Hoth")
tattoine = Planet.create(name: "Tattoine")

hot = Style.create(name: "Hot")
cold = Style.create(name: "Cold")

user_1.spaces.create(name: "Winter Wonderland", price: "5.99", description: "Cold is SO hot right now.", occupancy: 50, planet: hoth, style: cold)
user_2.spaces.create(name: "Desert Paradise", price: "5.99", description: "Hot is SO hot right now.", occupancy: 50, planet: tattoine, style: hot)
