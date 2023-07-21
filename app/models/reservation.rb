class Reservation < ApplicationRecord
  belongs_to :user
  # TODO: add belongs_to :laptop
end
