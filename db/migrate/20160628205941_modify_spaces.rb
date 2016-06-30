class ModifySpaces < ActiveRecord::Migration
  def change
    remove_column :spaces, :foot
    remove_column :spaces, :size_id

    rename_column :spaces, :retired, :available
    rename_column :spaces, :category_id, :planet_id

    add_column :spaces, :description, :string
  end
end
