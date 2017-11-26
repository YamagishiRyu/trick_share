class AddRememberDigestToContributors < ActiveRecord::Migration[5.1]
  def change
    add_column :contributors, :remember_digest, :string
  end
end
