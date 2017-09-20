class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, :limit => 200
      t.string :phone_number, :limit => 20
      t.string :full_name, :limit => 200
      t.string :password_digest
      t.string :key, :limit => 100
      t.string :account_key, :limit => 100
      t.string :metadata, :limit => 2000

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :phone_number, unique: true
    add_index :users, :key, unique: true
    add_index :users, :account_key, unique: true
  end
end
