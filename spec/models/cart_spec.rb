require "rails_helper"

RSpec.describe Cart, type: :model do
  scenario "cart has contents" do
    cart = Cart.new("1" => 1)
    expect(cart.contents).to eq("1" => 1)
  end

  scenario "cart adds spaces" do
    cart = Cart.new("1" => 1)
    space = create(:space)
    cart.add_space(space.id)
    expect(cart.contents).to eq("1" => 1, space.id.to_s => 1)
  end

  scenario "cart has a total" do
    cart = Cart.new("1" => 1, "2" => 2, "3" => 3)
    expect(cart.total).to eq(6)
  end

  scenario "cart returns total for a space" do
    cart = Cart.new("1" => 1, "2" => 2, "3" => 3)
    expect(cart.count_of(2)).to eq(2)
  end

  scenario "cart returns total price" do
    space_1, space_2, space_3 = create_list(:space, 3)
    cart = Cart.new(space_1.id.to_s => 1, space_2.id.to_s => 2, space_3.id.to_s => 5)
    price = space_1.price + space_2.price * 2 + space_3.price * 5
    expect(cart.total_price).to eq(price)
  end

  scenario "cart removes a space" do
    space_1, space_2, space_3 = create_list(:space, 3)
    cart = Cart.new(space_1.id.to_s => 1, space_2.id.to_s => 2, space_3.id.to_s => 5)
    cart.remove_space(space_3.id)
    expect(cart.contents).to eq(space_1.id.to_s => 1, space_2.id.to_s => 2)
  end

  scenario "can increase space quantity" do
    space = create(:space)
    cart = Cart.new(space.id.to_s => 1)
    cart.update_quantity(space.id, "plus")
    expect(cart.contents).to eq(space.id.to_s => 2)
  end

  scenario "can decrease space quantity" do
    space = create(:space)
    cart = Cart.new(space.id.to_s => 3)
    cart.update_quantity(space.id, "minus")
    expect(cart.contents).to eq(space.id.to_s => 2)
  end

  scenario "removes space if quantity decreases from 1" do
    space = create(:space)
    cart = Cart.new(space.id.to_s => 1)
    cart.update_quantity(space.id, "minus")
    expect(cart.contents).to eq({})
  end
end
