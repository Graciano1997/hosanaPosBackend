class Api::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  def index
    products=[]

    @products=Product.all
    @products.each do |item|
      products.push(display_product(item))
    end unless @products.size.zero?
    render json: { success: true, data: products }, status: :ok
  end

  def show
    render json: { success: true, data: @product }
  end

  def product_fields
    product=Product.column_names
    render json: { success: true, data: product }, status: :ok
  end

  def create
    product=Product.new(product_params)
    if product.save
      render json: { success: true, product: display_product(product) }, status: :ok
    else
      render json: { error: true, message: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: { success: true, product: display_product(@product)
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
    params.expect(product: [ :code, :name, :qty, :price, :manufacture_date, :expire_date, :category_id, :cost_price, :mesure_unit, :brand, :description, :status, :weight, :dimension, :location_in_stock, :taxes, :keyword, :observation, :promotion, :discount, :product_type ])
  end

  def set_product
    @product=Product.find_by(id: params[:id])
  end

  def display_product(product)
    {
      id: product.id,
      name: product.name,
      code: product.code,
      qty: product.qty,
      output: product.output,
      price: product.price,
      cost_price: product.cost_price,
      category: product.category.name,
      status: product.status,
      category_id: product.category_id,
      brand: product.brand,
      mesure_unit: product.mesure_unit,
      weight: product.weight,
      manufacture_date: product.manufacture_date,
      expire_date: product.expire_date,
      taxes: product.taxes,
      location_in_stock: product.location_in_stock,
      description: product.description,
      dimension: product.dimension,
      observation: product.observation,
      promotion: product.promotion,
      discount: product.discount,
      product_type: product.product_type,
      keyword: product.keyword,
      created_at: product.created_at,
      updated_at: product.updated_at
    }
  end
end
