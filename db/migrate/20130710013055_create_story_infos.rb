class CreateStoryInfos < ActiveRecord::Migration
  def change
    create_table :story_infos do |t|
      t.references :user
      t.references :story

      t.timestamps
    end
    add_index :story_infos, :user_id
    add_index :story_infos, :story_id
  end
end
