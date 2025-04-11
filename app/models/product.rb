class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates_numericality_of :qty
  has_many :sale_product
  has_many :expired_product
end
