class DateValidator < ActiveModel::Validator

  def validate(record)
    if Reservation.all.count == 0
        true
    else
      if Reservation.find_by(start_date: record.start_date) || Reservation.find_by(end_date: record.end_date)
        record.errors[:start_date] << "This date range is unavailable"
      end

      Reservation.all.each do |reservation|
        if reservation.start_date < record.end_date && record.end_date <= reservation.end_date
          record.errors[:start_date] << "This end date is unavailable"
        end
      end

      Reservation.all.each do |reservation|
        if reservation.start_date <= record.start_date && record.start_date < reservation.end_date
          record.errors[:start_date] << "This start date is unavailable"
        end
      end

      Reservation.all.each do |reservation|
        if reservation.start_date >= record.start_date && reservation.end_date <= record.end_date
          record.errors[:start_date] << "This date range is unavailable"
        end
      end
    end
  end
end
