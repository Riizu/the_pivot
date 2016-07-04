class DateValidator < ActiveModel::Validator

  def validate(new_reservation)
    if check_for_existing_endpoints(new_reservation)
    else
      check_overlaps(new_reservation)
    end
  end

  def self.validate_cart_reservation(space_id, start_date, end_date)
    Reservation.new(space_id: space_id, start_date: start_date, end_date: end_date)
  end

  def check_overlaps(new_reservation)
    Reservation.where(space: new_reservation.space).all.each do |existing_reservation|
      check_start_overlap(existing_reservation, new_reservation)
      check_end_overlap(existing_reservation, new_reservation)
      check_contains_existing(existing_reservation, new_reservation)
    end
  end

  def check_start_overlap(existing_reservation, new_reservation)
    if existing_reservation.start_date < new_reservation.end_date && new_reservation.end_date <= existing_reservation.end_date
      new_reservation.errors[:start_date] << "This end date is unavailable"
    end
  end

  def check_end_overlap(existing_reservation, new_reservation)
    if existing_reservation.start_date <= new_reservation.start_date && new_reservation.start_date < existing_reservation.end_date
      new_reservation.errors[:start_date] << "This start date is unavailable"
    end
  end

  def check_contains_existing(existing_reservation, new_reservation)
    if existing_reservation.start_date >= new_reservation.start_date && existing_reservation.end_date <= new_reservation.end_date
      new_reservation.errors[:start_date] << "This date range is unavailable"
    end
  end

  def check_for_existing_endpoints(new_reservation)
    if Reservation.find_by(space: new_reservation.space, start_date: new_reservation.start_date) || Reservation.find_by(space: new_reservation.space, end_date: new_reservation.end_date)
      new_reservation.errors[:start_date] << "This date range is unavailable"
    end
  end
end
