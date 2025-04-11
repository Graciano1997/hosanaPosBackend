class Category < ApplicationRecord
  belongs_to :parent_category, class_name: "Category", optional: true
  has_many :subcategories, class_name: "Category", foreign_key: "parent_category_id"
  validates :name, presence: true, uniqueness: true
end
