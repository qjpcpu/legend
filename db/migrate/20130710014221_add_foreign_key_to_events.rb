class AddForeignKeyToEvents < ActiveRecord::Migration
  def change
  	add_column :events,:story_id,:integer
  	add_index :events,:story_id
  end
end
