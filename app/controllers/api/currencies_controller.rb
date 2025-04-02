class Api::CurrenciesController < ApplicationController
  before_action :set_currency, only: %i[ show destroy  ]

  def index
    @currencies=Currency.all
    render json: { success: true, data: @currencies }, status: :ok
  end

    def show
      render json: { success: true, data: @currency }, status: :ok
    end

    def create
      currency = Currency.new(currency_params)
      if currency.save
        render json: { success: true, currency: currency }, status: :ok
      else
        render json: { error: false, message: currency.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
       if @currency.update(currency_params)
          render json: { success: true, currency: @currency }, status: :ok
       else
          render json: { error: true, message: @currency.errors.full_messages }, status: :unprocessable_entity
       end
    end

   def destroy
     if @currency.destroy
       render json: { success: true, id: @currency.id }, status: :ok
     else
       render json: { error: true, message: @currency.errors.full_messages }, status: :ok
     end
   end

   def active
    active_currency=Currency.where(status: true).first()
      render json: { success: true, currency: active_currency }, status: :ok
   end

   private
   def set_currency
     @currency=Currency.find_by(id: params[:id])
   end

   def currency_params
    params.expect(currency: [ :name, :symbol, :status ])
   end
end
