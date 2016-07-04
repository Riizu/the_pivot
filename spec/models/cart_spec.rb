require "rails_helper"

RSpec.describe Cart, type: :model do
  scenario "cart has contents" do
    cart = Cart.new("1" => ["1.0", "2016/12/01", "2016/12/03"])
    expect(cart.contents).to eq("1" => ["1.0", "2016/12/01", "2016/12/03"])
  end

  scenario "cart adds spaces" do
    cart = Cart.new({})
    space = create(:space)
    cart.add_reservation(space.id, "3.0", "2016/12/01", "2016/12/03")
    expect(cart.contents).to eq(space.id.to_s => ["3.0", "2016/12/01", "2016/12/03"])
  end

  scenario "cart has a total" do
    cart = Cart.new("1" => ["1.0", "2016/12/01", "2016/12/03"], "2" => [1, "2016/12/03", "2016/12/05"])
    expect(cart.total).to eq(2)
  end

  scenario "cart returns total price" do
    space_1, space_2, space_3 = create_list(:space, 3)
    cart = Cart.new(space_1.id.to_s => [space_1.price, "2016/12/01", "2016/12/03"], space_2.id.to_s => [space_2.price, "2016/12/03", "2016/12/05"], space_3.id.to_s => [space_3.price, "2016/12/05", "2016/12/07"])
    price = space_1.price*2 + space_2.price*2 + space_3.price*2
    expect(cart.total_price).to eq(price)
  end

  scenario "cart removes a reservation" do
    space_1, space_2, space_3 = create_list(:space, 3)
    cart = Cart.new(space_1.id.to_s => [space_1.price, "2016/12/01", "2016/12/03"], space_2.id.to_s => [space_2.price, "2016/12/03", "2016/12/05"], space_3.id.to_s => [space_3.price, "2016/12/05", "2016/12/07"])
    cart.remove_reservation(space_3.id)
    expect(cart.contents).to eq(space_1.id.to_s => [space_1.price, "2016/12/01", "2016/12/03"], space_2.id.to_s => [space_2.price, "2016/12/03", "2016/12/05"])
  end
end
