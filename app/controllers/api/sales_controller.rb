class Api::SalesController < ApplicationController
  before_action :set_sale, only: %i[show update destroy]

  def index
    sales=[]
    @sales=Sale.all
    @sales.each do |item|
    sales.push(display_sale(item))
    end unless @sales.size.zero?
    render json: { success: true, data: sales }, status: :ok
  end

  def show
    render json: { success: true, data: @sale }
  end

  def create
    client_p=params[:client]
    sale_p=params[:sale]
    sale_items = params[:items]

     client = Client.new(name: client_p[:name], phone: client_p[:phone], email: client_p[:email], address: client_p[:address], client_type: client_p[:client_type], nif: client_p[:nif])
     if client.save
        sale = Sale.new(qty: sale_p[:qty], payment_way: sale_p[:payment_way], descount: sale_p[:descount], difference: (sale_p[:received_cash].to_d - sale_p[:total].to_d), total: sale_p[:total], client_id: client.id, user_id: 1, received_cash: sale_p[:received_cash])
        if sale.save
          sale_items.each do |item|
            SaleProduct.create!(sale_id: sale.id, product_id: item[:id], qty: item[:qty], subtotal: item[:total])
          end
          render json: { success: true }, status: :created
        else
          render json: { error: true, message: sale.errors.full_messages }, status: :unprocessable_entity
        end
     else
        render json: { error: true, message: client.errors.full_messages }, status: :unprocessable_entity
     end
  end

  def update
  end

  def destroy
    if @sale.destroy
      render json: { success: true, id: @sale.id  }, status: :ok
    else
      render json: { error: true, message: @sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sale_params
    params.expect(sale: [ :qty, :payment_way, :descount, :total, :client_id, :user_id ])
  end

  def client_params
    params.expect(client: [ :name, :phone, :email, :address, :type, :nif ])
  end

  def set_sale
    @sale=Sale.find_by(id: params[:id])
  end

  def display_sale(sale)
    {
      id: sale.id,
      qty: sale.qty,
      payment_way: sale.payment_way,
      descount: sale.descount,
      difference: sale.difference,
      received_cash: sale.received_cash,
      total: sale.total,
      client_id: sale.client_id,
      client: Client.find(sale.client_id).name,
      user_id: sale.user_id,
      operator: User.find(sale.user_id).name,
      created_at: sale.created_at,
      updated_at: sale.updated_at
    }
  end
end
