class CreateContributors < ActiveRecord::Migration[5.1]
  def change
    create_table :contributors do |t|
      t.string :email
      t.string :nick_name

      t.timestamps
    end
  end
end
