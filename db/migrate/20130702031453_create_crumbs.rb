class CreateCrumbs < ActiveRecord::Migration
  def change
    create_table :crumbs do |t|
      t.string :caption
      t.text :description
      t.attachment :media

      t.timestamps
    end
  end
end
