class AddStatusToModels < ActiveRecord::Migration
  def change
    add_column :orders, :active, :boolean, default: true
    add_column :planets, :active, :boolean, default: true
    add_column :spaces, :active, :boolean, default: true
    add_column :styles, :active, :boolean, default: true
    add_column :users, :active, :boolean, default: true
  end
end
