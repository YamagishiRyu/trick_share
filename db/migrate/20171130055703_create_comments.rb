class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :trick_id
      t.integer :contributor_id
      t.text :content

      t.timestamps
    end
    add_index :comments, :trick_id
    add_index :comments, :contributor_id
  end
end
