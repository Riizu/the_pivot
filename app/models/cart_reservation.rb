class CartReservation < SimpleDelegator
  attr_accessor :price, :start_date, :end_date

  def initialize(space, price, start_date, end_date)
    super(space)
    @price = price
    @start_date = start_date
    @end_date = end_date
  end
end
