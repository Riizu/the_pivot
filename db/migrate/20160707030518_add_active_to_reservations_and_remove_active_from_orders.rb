class AddActiveToReservationsAndRemoveActiveFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :active
    add_column :reservations, :active, :boolean, default: true
  end
end
