class AddForeignKeyToCrumb < ActiveRecord::Migration
  def change
  	add_column :crumbs, :event_id, :integer
  	add_index :crumbs, :event_id
  end
end
