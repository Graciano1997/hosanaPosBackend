class ExpiredProductsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    expired_products = Product.where("expire_date < ?", Date.today)

    expired_products.find_each do |product|
      if ExpiredProduct.where(expired_on: product.expire_date, product_id: product.id).empty?
        difference=(product.qty - product.output)
        ExpiredProduct.create!(expired_on: product.expire_date, qty: difference, total: difference * product.price, product_id: product.id)
      end
    end
  end
end
