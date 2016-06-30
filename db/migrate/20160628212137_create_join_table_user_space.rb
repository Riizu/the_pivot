class CreateJoinTableUserSpace < ActiveRecord::Migration
  def change
    create_join_table :users, :spaces do |t|
      # t.index [:user_id, :space_id]
      # t.index [:space_id, :user_id]
    end
  end
end
