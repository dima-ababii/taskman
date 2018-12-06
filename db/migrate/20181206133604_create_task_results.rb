class CreateTaskResults < ActiveRecord::Migration[5.2]
  def change
    create_table :task_results do |t|
      t.string :file
      t.string :file_hex
      t.text :description
      t.integer :user_id, null: false
      t.integer :task_id, null: false
      t.timestamps
    end
  end
end
