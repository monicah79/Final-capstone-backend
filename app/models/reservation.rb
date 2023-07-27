class Reservation < ApplicationRecord
  belongs_to :user
  has_one :laptop_reservation, dependent: :destroy
  has_many :laptops, through: :laptop_reservation
end
