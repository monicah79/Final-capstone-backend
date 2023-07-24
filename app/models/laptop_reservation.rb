class LaptopReservation < ApplicationRecord
  belongs_to :laptop
  belongs_to :reservation

  validates :city, presence: true
  validates :quantity, numericality: { greater_than: 0 }
end
