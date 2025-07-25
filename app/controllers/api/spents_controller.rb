class Api::SpentsController < ApplicationController
  before_action :set_spent, only: %i[ show destroy update ]
  include YearBalance

  def index
    spents=[]
    @spents=Spent.all.order(id: :asc)
    @spents.each do |item|
      spents.push(display_spent(item))
    end unless @spents.size.zero?
    render json: { success: true, data: spents }, status: :ok
  end

  def last_spents
    spents=[]
    @spents=Spent.order(created_at: :desc).limit(params[:number])
    @spents.each do |item|
      spents.push(display_spent(item))
    end unless @spents.size.zero?
    render json: { success: true, data: spents }, status: :ok
  end

  def min_year_date_spents
    min_year=Spent.minimum(:created_at).year
    if min_year
      render json: { success: true, year: min_year }, status: :ok
    end
  end

  def anual_spents
    current_year = params[:year].to_i
    anual_Balance("Spent", "amount", current_year)
  end

  def show
    render json: { success: true, data: @spent }, status: :ok
  end

  def create
    spent = Spent.new(spent_params)

    if spent.save
      render json: { success: true, spent: display_spent(spent) }, status: :ok
    else
      render json: { error: false, message: spent.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @spent.update(spent_params)
      render json: { success: true, spent: display_spent(@spent) }, status: :ok
    else
      render json: { error: true, message: @spent.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @spent.destroy
      render json: { success: true, id: @spent.id }, status: :ok
    else
      render json: { error: true, message: @spent.errors.full_messages }, status: :ok
    end
  end

  private

  def spent_params
    params.expect(spent: [ :motive, :amount, :user_id ])
  end

  def set_spent
    @spent = Spent.find_by(id: params[:id])
  end

  def display_spent(spent)
    {
      id: spent.id,
      motive: spent.motive,
      amount: spent.amount,
      user: spent.user.name,
      image: spent.user.image.attached? ? url_for(spent.user.image) : "none",
      user_id: spent.user_id,
      created_at: spent.created_at,
      updated_at: spent.updated_at
    }
  end
end
