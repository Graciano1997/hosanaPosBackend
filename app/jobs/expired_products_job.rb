class ExpiredProductsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    expired_products = Product.where("expire_date < ?", Date.today)
    
     expired_products.find_each do |product|
      if ExpiredProduct.where(expired_on: product.expire_date, product_id: product.id).empty? 
        difference=0
        
        if product.output
          difference=(product.qty - product.output)
        else
          difference=product.qty
        end

        ExpiredProduct.create!(expired_on: product.expire_date, qty: difference, total: difference * product.price, product_id: product.id)
        product.status=false
        product.save
       end
     end
  end
end
