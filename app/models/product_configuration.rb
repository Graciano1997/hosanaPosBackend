class ProductConfiguration < ApplicationRecord
  validates :field, presence: true, uniqueness: true
end
