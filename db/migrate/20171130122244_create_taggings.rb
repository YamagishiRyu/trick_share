class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.integer :trick_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :taggings, :trick_id
    add_index :taggings, :tag_id
    add_index :taggings, [:trick_id, :tag_id], unique: true
  end
end
