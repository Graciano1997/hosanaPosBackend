class Spent < ApplicationRecord
  belongs_to :user, optional: true
end
