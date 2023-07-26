class CreateLaptops < ActiveRecord::Migration[7.0]
  def change
    create_table :laptops do |t|
      t.string :name
      t.float :price
      t.string :cpu
      t.string :picture
      t.integer :memory
      t.integer :storage
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
