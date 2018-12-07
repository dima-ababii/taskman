class CreateTasksUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks_users do |t|
      t.string :state, null: false, default: 'new'
      t.integer :task_id, null: false
      t.integer :user_id, null: false
      t.datetime :assigned_at
      t.datetime :unassigned_at
      t.timestamps
      t.index :task_id
      t.index :user_id
    end
  end
end
