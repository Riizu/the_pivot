class ChangeAvailableToApproved < ActiveRecord::Migration
  def change
    rename_column :spaces, :available, :approved
  end
end
