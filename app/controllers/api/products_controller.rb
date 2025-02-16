class Api::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  def index
    @products=Product.all
    render json: { success: true, data: @products }, status: :ok
  end

  def show
    render json: { success: true, data: @product }
  end


  def create
    product=Product.new(product_params)
    if product.save
      render json: { success: true, product: product }, status: :ok
    else
      render json: { error: true, message: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: { success: true, product: {
                id: @product.id,
name: @product.name,
code: @product.code,
qty: @product.qty,
price: @product.price,
category_id: @product.category_id,
created_at: @product.created_at,
updated_at: @product.updated_at,
expire_date: @product.expire_date,
manufacture_date: @product.manufacture_date
}
      }, status: :ok
    else
      render json: { error: true, message: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      render json: { success: true, id: @product.id  }, status: :ok
    else
      render json: { error: true, message: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.expect(product: [ :code, :name, :qty, :price, :manufacture_date, :expire_date, :category_id ])
  end

  def set_product
    @product=Product.find_by(id: params[:id])
  end
end
