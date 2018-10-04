class CreateTasksUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks_users do |t|
      t.string :state, null: false, default: 'new'
      t.integer :task_id, null: false
      t.integer :user_id, null: false
      t.timestamps
      t.index :task_id
      t.index [:task_id, :user_id], unique: true
    end
  end
end
