class AddAddminToContributors < ActiveRecord::Migration[5.1]
  def change
    add_column :contributors, :admin, :boolean, default: false
  end
end
