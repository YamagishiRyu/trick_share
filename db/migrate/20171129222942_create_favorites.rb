class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.integer :contributor_id
      t.integer :trick_id

      t.timestamps
    end
    add_index :favorites, :contributor_id
    add_index :favorites, :trick_id
    add_index :favorites, [:contributor_id, :trick_id], unique: true
  end
end
