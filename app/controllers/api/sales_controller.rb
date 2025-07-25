require "json"

class Api::SalesController < ApplicationController
  include Print
  include YearBalance

  before_action :set_sale, only: %i[show update destroy reprinting_invoice]

  def index
    sales=[]
    @sales=Sale.all.order(id: :desc)
    @sales.each do |item|
    sales.push(display_sale(item))
    end unless @sales.size.zero?
    render json: { success: true, data: sales }, status: :ok
  end

  def show
    render json: { success: true, data: @sale }
  end

  def today_balance
    monthly_total_spents=[]
    (1..12).each do |month|
      current_month=Date.new(current_year, month, 1)
      monthly_total_spents << Spent.where(created_at: current_month..current_month.end_of_month).sum(:amount)
    end
    render json: { success: true, data: monthly_total_spents }, status: :ok
  end

  def anual_sales
    current_year = params[:year].to_i
    anual_Balance("Sale", "total", current_year)
  end

  def create
    client_p=params[:client]
    sale_p=params[:sale]
    sale_items = params[:items]
    client = Client.where("nif=? or email=? ", client_p[:nif], client_p[:email]).first ||  Client.new(name: client_p[:name], phone: client_p[:phone], email: client_p[:email], client_type: client_p[:client_type], nif: client_p[:nif], address: client_p[:address])

    if sale_p[:invoiceType] == 2
      sale = Sale.new(qty: sale_p[:qty], payment_way: sale_p[:payment_way], descount: sale_p[:descount], difference: sale_p[:difference], total: sale_p[:total], client: client, user_id: sale_p[:user_id], received_cash: sale_p[:received_cash], received_tpa: sale_p[:received_tpa], invoice_number: InvoiceNumber.next!)
      sale_items.each do |item|
        sale.sale_products << SaleProduct.new(sale_id: sale.id, product_id: item[:id], qty: item[:qty], subtotal: item[:total])
      end

      render json: { success: true, invoice_item: display_invoice(display_sale(sale)) }, status: :ok

    else
      if client.save
        sale = Sale.new(qty: sale_p[:qty], payment_way: sale_p[:payment_way], descount: sale_p[:descount], difference: sale_p[:difference], total: sale_p[:total], client_id: client.id, user_id: sale_p[:user_id], received_cash: sale_p[:received_cash], received_tpa: sale_p[:received_tpa], invoice_number: InvoiceNumber.next!)
        if sale.save
          sale_items.each do |item|
            SaleProduct.create!(sale_id: sale.id, product_id: item[:id], qty: item[:qty], subtotal: item[:total])
          end

          render json: { success: true, invoice_item: display_invoice(display_sale(sale)) }, status: :created

        else
          render json: { error: true, message: sale.errors.full_messages }, status: :unprocessable_entity
        end
      else
          render json: { error: true, message: client.errors.full_messages }, status: :unprocessable_entity
      end
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

  def reprinting_invoice
    render json: { success: true, invoice_item: display_invoice(display_sale(@sale)) }, status: :ok
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
      received_tpa: sale.received_tpa,
      total: sale.total,
      client_id: sale.client_id,
      client: sale.client.name ? sale.client.name : "#############",
      client_phone: sale.client.phone,
      user_id: sale.user_id,
      sale_products: display_sale_products(sale.sale_products),
      operator: User.find(sale.user_id).name,
      invoice_number: sale.invoice_number,
      created_at: sale.created_at ? sale.created_at : Time.now,
      updated_at: sale.updated_at ? sale.updated_at : Time.now
    }
  end

  def display_sale_products(sale_products)
    sale_products_items=[]
    sale_products.each do |item|
      sale_products_items.push(display_sale_product(item))
    end
    sale_products_items
  end

  def display_sale_product(sale_product)
    {
      code: sale_product.product.code,
      name: sale_product.product.name,
      qty: sale_product.qty,
      discount: sale_product.product.discount ? sale_product.product.discount : 0,
      taxes: sale_product.product.taxes ? sale_product.product.taxes : 0,
      price: sale_product.product.price,
      subtotal: sale_product.subtotal
    }
  end
end
