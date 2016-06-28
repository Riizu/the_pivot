class ModifyReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :quantity

    rename_column :reservations, :sock_price, :total
    rename_column :reservations, :sock_id, :space_id

    add_column :reservations, :start_date, :datetime
    add_column :reservations, :end_date, :datetime
  end
end
