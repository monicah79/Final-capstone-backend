class CreateJoinTableLaptopReservation < ActiveRecord::Migration[7.0]
  def change
    create_join_table :laptops, :reservations do |t|
      t.index [:laptop_id, :reservation_id]
      t.index [:reservation_id, :laptop_id]
      t.string :city
      t.integer :quantity
    end
  end
end
