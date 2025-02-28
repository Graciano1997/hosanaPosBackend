class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates_numericality_of :qty
  validates_presence_of :output
  has_many :sale_product
end
