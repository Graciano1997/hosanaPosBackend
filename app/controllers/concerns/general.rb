module General
  extend ActiveSupport::Concern
  enum saleType = {
    SALE: 1,
    PORFORM: 2
  }
end
