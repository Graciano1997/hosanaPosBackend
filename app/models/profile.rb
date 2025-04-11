class Profile < ApplicationRecord
  has_many :users
  has_many :app_permitions
end
