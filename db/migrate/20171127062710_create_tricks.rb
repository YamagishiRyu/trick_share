class CreateTricks < ActiveRecord::Migration[5.1]
  def change
    create_table :tricks do |t|
      t.string :title
      t.text :content
      t.integer :duration
      t.references :contributor, foreign_key: true

      t.timestamps
    end
    add_index :tricks, [:contributor_id, :created_at]
  end
end
