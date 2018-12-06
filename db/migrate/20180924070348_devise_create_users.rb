class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, default: "", null: false
      t.string :encrypted_password, default: "", null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :role, null: false, default: 'student'
      t.boolean :is_active, default: true
      t.timestamps null: false
    end
    
    add_index :users, :email, unique: true
  end
end
