require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context "validations" do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end

  context "can calculate total for nights in stay" do
    it "calculates correctly" do
      space = create(:space)
      order = create(:order)
      reservation = Reservation.create(start_date: "2016/07/15", end_date: "2016/07/17", space: space, order: order, total: 10.0)
      expect(reservation.total_nights).to eq(2)
    end
  end

  context "can calculate total price for a trip" do
    it "calculates correctly" do
      space = create(:space, price: 5)
      order = create(:order)
      reservation = Reservation.create(start_date: "2016/07/15", end_date: "2016/07/17", space: space, order: order, total: 10.0)
      expect(reservation.total_price).to eq(10)
    end
  end

  context "validations" do
    it "will allow creation if no reservations exist" do
      space = create(:space)
      order = create(:order)
      new_reservation = Reservation.new(space: space, order: order, total: 15, start_date: "2016/07/15", end_date: "2016/07/20")
      expect(new_reservation).to be_valid
    end

    it "won't allow creation if start date is taken" do
      reservation = create(:reservation)
      new_reservation = Reservation.new(space: reservation.space, order: reservation.order, total: 15, start_date: reservation.start_date, end_date: "2016/07/20")
      expect(new_reservation).to_not be_valid
    end

    it "won't allow creation if end date is taken" do
      reservation = create(:reservation)
      new_reservation = Reservation.new(space: reservation.space, order: reservation.order, total: 15, start_date: "2016/07/14", end_date: reservation.end_date)
      expect(new_reservation).to_not be_valid
    end

    it "won't validate if end date is between existing start/end dates" do
      reservation = create(:reservation)
      new_reservation = Reservation.new(space: reservation.space, order: reservation.order, total: 15, start_date: "2016/07/14", end_date: "2016/07/16")
      expect(new_reservation).to_not be_valid
    end

    it "won't validate if start date is between existing start/end dates" do
      reservation = create(:reservation)
      new_reservation = Reservation.new(space: reservation.space, order: reservation.order, total: 15, start_date: "2016/07/16", end_date: "2016/07/22")
      expect(new_reservation).to_not be_valid
    end

    it "won't validate if both dates are between start/end dates" do
      reservation = create(:reservation)
      new_reservation = Reservation.new(space: reservation.space, order: reservation.order, total: 15, start_date: "2016/07/16", end_date: "2016/07/17")
      expect(new_reservation).to_not be_valid
    end

    it "won't validate if both dates are contain exisiting start/end dates" do
      reservation = create(:reservation)
      new_reservation = Reservation.new(space: reservation.space, order: reservation.order, total: 15, start_date: "2016/07/14", end_date: "2016/07/19")
      expect(new_reservation).to_not be_valid
    end


    it "validates if new end date is on exisiting start date" do
      reservation = create(:reservation)
      new_reservation = Reservation.new(space: reservation.space, order: reservation.order, total: 15, start_date: "2016/07/13", end_date: "2016/07/15")
      expect(new_reservation).to be_valid
    end

    it "validates if new start date is on exisiting end date" do
      reservation = create(:reservation)
      new_reservation = Reservation.new(space: reservation.space, order: reservation.order, total: 15, start_date: "2016/07/18", end_date: "2016/07/22")
      expect(new_reservation).to be_valid
    end

  end

end
