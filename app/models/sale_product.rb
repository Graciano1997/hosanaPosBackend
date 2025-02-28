class SaleProduct < ApplicationRecord
  belongs_to :sale
  belongs_to :product
  after_save_commit :decrease_product_qty

  def decrease_product_qty
    product=Product.find(self.product_id)

    product.qty -= self.qty if product.qty > 0

    if product.output
    product.output +=self.qty
    else
    product.output =self.qty
    end
    product.save
  end
end
