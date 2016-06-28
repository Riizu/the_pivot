class RenameSocksToSpaces < ActiveRecord::Migration
  def change
    rename_table :socks, :spaces
  end
end
