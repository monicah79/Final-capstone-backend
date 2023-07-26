class LaptopReservation < ApplicationRecord
  self.table_name = 'laptops_reservations'

  belongs_to :laptop
  belongs_to :reservation

  validates :city, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  attribute :start_date, :date
  attribute :end_date, :date
end
