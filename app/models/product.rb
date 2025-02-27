class Product < ApplicationRecord
  include View
  belongs_to :category
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
end
