FactoryGirl.define do
  factory :style do
    name { generate(:style_name) }
  end

  sequence :style_name do |n|
    "#{n}_style"
  end

  factory :planet do
    name { generate(:planet_name) }
  end

  sequence :planet_name do |n|
    "#{n}_planet"
  end

  factory :space do
    name { generate(:space_name) }
    price
    description "Test description"
    available "true"
    planet
    style
  end

  sequence :space_name do |n|
    "#{n} space name"
  end

  sequence :price do |n|
    n
  end

  factory :user do
    name { generate(:name_of_user) }
    username { generate(:username) }
    password "password"
    password_confirmation "password"
  end

  sequence :username do |n|
    "person#{n}"
  end

  sequence :name_of_user do |n|
    "name#{n}"
  end
end
