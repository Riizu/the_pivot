class RenameCategoriesToPlanets < ActiveRecord::Migration
  def change
    rename_table :categories, :planets
  end
end
