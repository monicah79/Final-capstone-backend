class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.datetime :datetime, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
