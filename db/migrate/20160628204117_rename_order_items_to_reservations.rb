class RenameOrderItemsToReservations < ActiveRecord::Migration
  def change
    rename_table :order_items, :reservations
  end
end
