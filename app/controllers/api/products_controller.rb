class Api::ProductsController < ApplicationController
  # before_action :authorize_request
  include YearBalance
  before_action :set_product, only: %i[show update destroy]

  def index
    products=[]
    @products=Product.all.order(id: :asc)
    @products.each do |item|
      products.push(display_product(item))
    end unless @products.size.zero?
    render json: { success: false, data: products }, status: :ok
  end

  def show
    render json: { success: true, data: @product }
  end

  def product_fields
    product=Product.column_names
    render json: { success: true, data: product }, status: :ok
  end

  def anual_expireds
    current_year = params[:year].to_i
    anual_Balance("ExpiredProduct", "total", current_year, date_field: "created_at")
  end

  def expireds
    products=[]
    @products=ExpiredProduct.all
    @products.each do |item|
      products.push(display_product_expired(item))
    end unless @products.size.zero?

    render json: { success: true, data: products }, status: :ok
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

  def expired_product_job
    ExpiredProductsJob.perform_later
    render json: { success: true, message: "Expired products check has been queued" }
  end

  def anual_expireds
    current_year = params[:year].to_i
    monthly_total_expireds=[]
    (1..12).each do |month|
      current_month=Date.new(current_year, month, 1)
      monthly_total_expireds << ExpiredProduct.where(expired_on: current_month..current_month.end_of_month).sum(:total)
    end
    render json: { success: true, data: monthly_total_expireds }, status: :ok
  end

  private

  def product_params
    params.expect(product: [ :code, :lote, :name, :qty, :price, :manufacture_date, :expire_date, :category_id, :cost_price, :mesure_unit, :brand, :description, :status, :weight, :dimension, :location_in_stock, :taxes, :keyword, :observation, :promotion, :discount, :product_type ])
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
      output: product.output ? product.output : 0,
      in_stock: product.output ? product.qty - product.output : product.qty,
      price: product.price,
      cost_price: product.cost_price,
      category: product.category.name,
      status: product.status,
      lote: product.lote,
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
      keyword: product.keyword,
      created_at: product.created_at.utc.strftime("%d-%m-%Y %H:%M:%S"),
      updated_at: product.updated_at.utc.strftime("%d-%m-%Y %H:%M:%S")
    }
  end

  def display_product_expired(expiredProduct)
    {
      id: expiredProduct.id,
      name: expiredProduct.product.name,
      code: expiredProduct.product.code,
      lote: expiredProduct.product.lote,
      qty: expiredProduct.qty,
      price: expiredProduct.product.price,
      category: expiredProduct.product.category.name,
      manufacture_date: expiredProduct.product.manufacture_date,
      expire_on: expiredProduct.product.expire_date,
      location_in_stock: expiredProduct.product.location_in_stock,
      total: expiredProduct.total
      }
  end
end
