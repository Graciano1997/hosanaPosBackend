require "json"

class Api::SalesController < ApplicationController
  before_action :set_sale, only: %i[show update destroy]

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

  def create
    puts params

    client_p=params[:client]
    sale_p=params[:sale]
    sale_items = params[:items]

    client = Client.new(name: client_p[:name], phone: client_p[:phone], email: client_p[:email], address: client_p[:address], client_type: client_p[:client_type], nif: client_p[:nif])
     if client.save
        sale = Sale.new(qty: sale_p[:qty], payment_way: sale_p[:payment_way], descount: sale_p[:descount], difference: sale_p[:difference], total: sale_p[:total], client_id: client.id, user_id: sale_p[:user_id], received_cash: sale_p[:received_cash], received_tpa: sale_p[:received_tpa])
        if sale.save
          sale_items.each do |item|
            SaleProduct.create!(sale_id: sale.id, product_id: item[:id], qty: item[:qty], subtotal: item[:total])
          end
          print(display_sale(sale), client_p)
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

  def print(sale, client)
    invoiceObject=File.new("gfatura/fatura.json", "w")
    products=[]

    company= Company.first

     sale[:sale_products].each do |item|
       products.push({ nome: item[:name], qtd: item[:qty], preco: item[:price].to_s + " kz" })
     end

      invoiceObject.syswrite({
        empresa: company.name,
        nif: company.nif,
        local: company.address,
        email: company.email,
        empresaPhone: company.phone,
        numeroRecibo: "001/2025",
        dataEmissao: sale[:created_at].utc.strftime("%d-%m-%Y %H:%M:%S"),
        vendedor: sale[:operator],
        troco: sale[:difference].to_s + " kz",
        telefone: client[:phone],
        cliente: sale[:client],
        desconto: sale[:descount].to_s + " kz",
        total: sale[:total].to_s + " kz",
        formaPagamento: sale[:payment_way],
        observacoes: "Lembre-se de seguir as orientações de uso dos medicamentos<br />Em caso de dúvida, consulte nossa equipe.",
        produto: products
    }
        .to_json+"\n")
        invoiceObject.close

        Dir.chdir("gfatura") do
          if Gem.win_platform?
            system('java -cp "application.jar;jackson-core-2.17.0.jar;jackson-databind-2.17.0.jar;jackson-annotations-2.17.0.jar" Gfatura')
          else
            system('java -cp "application.jar:jackson-core-2.17.0.jar:jackson-databind-2.17.0.jar:jackson-annotations-2.17.0.jar" Gfatura')
          end
        end
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
      client: sale.client.name ? sale.client.name : "Anônimo",
      user_id: sale.user_id,
      sale_products: display_sale_products(sale.sale_products),
      operator: User.find(sale.user_id).name,
      created_at: sale.created_at,
      updated_at: sale.updated_at
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
      price: sale_product.product.price,
      subtotal: sale_product.subtotal
    }
  end
end
