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
    planet
    style
    occupancy 4
  end

  sequence :space_name do |n|
    "#{n} space name"
  end

  sequence :price do |n|
    n
  end

  sequence :email do |n|
    "#{n}@email.com"
  end

  factory :user do
    first_name { generate(:first_name_of_user) }
    last_name { generate(:last_name_of_user) }
    username { generate(:username) }
    password "password"
    password_confirmation "password"
    email { generate(:email) }
    phone_number "123-456-7890"

    # factory :user_with_spaces do
    #   transient do
    #     spaces_count 5
    #   end
    #
    #   after(:create) do |user, evaluator|
    #     create_list(:space, evaluator.spaces_count, user: user)
    #   end
    # end

    factory :user_with_orders do
      transient do
        orders_count 5
      end
      after(:create) do |user, evaluator|
        create_list(:order, evaluator.orders_count, user: user)
      end
    end
  end

  # factory :user_with_a_reservation do
  #
  # end

  sequence :username do |n|
    "person#{n}"
  end

  sequence :first_name_of_user do |n|
    "first name#{n}"
  end

  sequence :last_name_of_user do |n|
    "last name#{n}"
  end

  factory :order do
    user
    status "completed"
  end

  factory :reservation do
    space
    order
    start_date "2016/07/15"
    end_date "2016/07/18"
    total 15
  end

end
