class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true
      t.boolean :availability, default: true
      t.integer :price, null: false

      t.timestamps
    end
  end
end
