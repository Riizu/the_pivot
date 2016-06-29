class UpdateSocksWithSlugAndName < ActiveRecord::Migration
  def change
    add_column :spaces, :slug, :string
    add_column :spaces, :occupancy, :integer
  end
end
