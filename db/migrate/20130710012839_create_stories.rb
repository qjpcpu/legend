class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.attachment :cover
      t.string :title
      t.text :instruction
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
