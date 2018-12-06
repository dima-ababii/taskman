class CreateTaskSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :task_settings do |t|
      t.integer :max_quantity_for_users, default: 20, null: false
      t.timestamps
    end
  end
end
