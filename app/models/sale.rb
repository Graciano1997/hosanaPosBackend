class Sale < ApplicationRecord
  belongs_to :client
  belongs_to :user
  has_many :products, through: :sale_product
  has_many :sale_products
end
