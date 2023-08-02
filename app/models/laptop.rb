class Laptop < ApplicationRecord
  has_many :laptop_reservations, dependent: :delete_all
  has_many :reservations, through: :laptop_reservations, dependent: :destroy

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true
  validates :cpu, presence: true
  validates :picture, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :memory, numericality: { greater_than: 0 }
  validates :storage, numericality: { greater_than: 0 }
end
