class Reservation < ApplicationRecord
  belongs_to :user
  has_many :laptops # , through: :laptop_reservations
end
