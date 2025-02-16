class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
end
