class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :password_digest
      t.string :verification_code
      t.boolean :verified, default: false
      t.timestamps
    end
  end
end
