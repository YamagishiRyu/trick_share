class CreateNeedTools < ActiveRecord::Migration[5.1]
  def change
    create_table :need_tools do |t|
      t.integer :trick_id
      t.integer :tool_id

      t.timestamps
    end
  end
end
