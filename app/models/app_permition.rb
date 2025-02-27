class AppPermition < ApplicationRecord
  belongs_to :AppModuleAction
  belongs_to :Profile
end
