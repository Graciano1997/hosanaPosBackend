class User < ApplicationRecord
  has_many :spents
  has_one_attached :image
end
