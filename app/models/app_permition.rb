class AppPermition < ApplicationRecord
  belongs_to :app_module_action
  belongs_to :profile
end
