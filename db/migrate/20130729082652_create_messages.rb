class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from
      t.integer :to
      t.integer :kind
      t.integer :priority,:default=>5
      t.text :content
      t.boolean :handled,:default=>false

      t.timestamps
    end
    add_index :messages,:from
    add_index :messages,:to
  end
end
