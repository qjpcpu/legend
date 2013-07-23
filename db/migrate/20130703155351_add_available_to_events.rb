class AddAvailableToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :available, :boolean,:default=>true
  end
end
