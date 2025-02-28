class User < ApplicationRecord
  has_many :spents
  has_one_attached :image
  belongs_to :profile
  has_many :sales
end
