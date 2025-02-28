class Api::CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show destroy update ]

  def index
    @categories=Category.all

    categories=[]

    @categories.each do |item|
      categories.push(display_category(item))
    end unless @categories.size.zero?
    render json: { success: true, data: categories }, status: :ok
  end

  def show
    render json: { success: true, data: display_category(@category) }, status: :ok
  end

  def create
    category_father = Category.find_by(id: params[:parent_category_id])
    category = Category.new(category_params)
    category.parent_category=category_father

    if category.save
      render json: { success: true, category: display_category(category) }, status: :ok
    else
      render json: { error: false, message: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    category_parent = Category.find_by(id: params[:parent_category_id])
    @category.parent_category=category_parent
    if @category.update(category_params)
      render json: { success: true, category: display_category(@category) }, status: :ok
    else
      render json: { error: true, message: @category.errors.full_messages }, status: :ok
    end
  end

  def destroy
    if @category.destroy
      render json: { success: true, id: @category.id }, status: :ok
    else
      render json: { error: true, message: @category.errors.full_messages }, status: :ok
    end
  end

  private

  def display_category(category)
    {
      id: category.id,
      name: category.name,
      category: category.description,
      status: category.status,
      parent_category_id: category.parent_category_id,
      parent_category: category.parent_category ? category.parent_category.name : "-----",
      created_at: category.created_at,
      updated_at: category.updated_at
    }
  end

  def category_params
    params.expect(category: [ :name, :description, :parent_category, :status ])
  end

  def set_category
    @category = Category.find_by(id: params[:id])
  end
end
