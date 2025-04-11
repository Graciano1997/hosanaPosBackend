class AppModuleAction < ApplicationRecord
  belongs_to :app_module
  belongs_to :app_action
  has_many :app_permitions
end
