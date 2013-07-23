class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :crumb
      t.date :start_date
      t.integer :duration,default: 1
      t.string :caption
      t.text :description

      t.timestamps
    end
    add_index :events, :crumb_id
  end
end
