class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.text :description
      t.string :file
      t.string :file_hex
      t.string :title, null: false
      t.date :expiration_date, null: false
      t.timestamps
      t.index :title, unique: true
    end
  end
end
