class ModifyPlanets < ActiveRecord::Migration
  def change
    rename_column :planets, :title, :name
  end
end
