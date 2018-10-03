class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.text :description
      t.string :file
      t.string :file_hex
      t.string :title, null: false
      t.string :state, null: false, default: 'new'
      t.timestamps
      t.index :state
      t.index :title
    end
  end
end
