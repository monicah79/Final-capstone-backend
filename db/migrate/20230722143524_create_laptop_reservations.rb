class CreateLaptopReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :laptop_reservations do |t|

      t.timestamps
    end
  end
end
