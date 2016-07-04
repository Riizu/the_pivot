class CartReservation < SimpleDelegator
  attr_accessor :price, :start_date, :end_date, :night_count, :total

  def initialize(space, price, start_date, end_date)
    super(space)
    @price = price
    @start_date = start_date
    @end_date = end_date
    @night_count = Date.parse(@end_date).mjd - Date.parse(@start_date).mjd
    @total = @price * @night_count
  end
end
