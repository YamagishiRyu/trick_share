class CreateNeedTools < ActiveRecord::Migration[5.1]
  def change
    create_table :need_tools do |t|
      t.integer :trick_id
      t.integer :tool_id

      t.timestamps
    end
    add_index :need_tools, :trick_id
    add_index :need_tools, :tool_id
    add_index :need_tools, [:trick_id, :tool_id], unique: true
  end
end
