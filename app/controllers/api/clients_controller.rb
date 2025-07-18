class Api::ClientsController < ApplicationController
    before_action :set_client, only: %i[show update destroy]

    def index
      clients=[]
      @clients=Client.all.order(id: :asc)
      @clients.each do |item|
        clients.push(display_client(item))
      end unless @clients.size.zero?
      render json: { success: false, data: clients }, status: :ok
    end

    def show
      render json: { success: true, data: @product }
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

    def set_client
      @client=Client.find_by(id: params[:id])
    end

    def display_client(client)
      {
        id: client.id,
        name: client.name,
        phone: client.phone,
        nif: client.nif,
        email: client.email,
        address: client.address,
        client_type: client.client_type,
        current_account: client.current_account,
        created_at: client.created_at.utc.strftime("%d-%m-%Y %H:%M:%S"),
        updated_at: client.updated_at.utc.strftime("%d-%m-%Y %H:%M:%S")
      }
    end
end
