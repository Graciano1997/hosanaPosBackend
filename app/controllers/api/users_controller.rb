class Api::UsersController < ApplicationController
  before_action :set_user, only: %i[ show destroy update ]

  def index
    users=[]
    @users=User.all
    @users.each do |item|
      users.push(display_user(item))
    end unless @users.size.zero?
    render json: { success: true, data: users }, status: :ok
  end

    def show
      render json: { success: true, data: display_user(@user) }, status: :ok
    end

    def create
      user = User.new(user_params)

      if user.save
        render json: { success: true, user: display_user(user) }, status: :ok
      else
        render json: { error: false, message: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        render json: { success: true, user: display_user(@user) }, status: :ok
      else
        render json: { error: true, message: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

   def destroy
     if @user.destroy
       render json: { success: true, id: @user.id }, status: :ok
     else
       render json: { error: true, message: @user.errors.full_messages }, status: :ok
     end
   end

  private
  def display_user(user)
    {
      id: user.id,
      name: user.name,
      email: user.email,
      profile: Profile.find(user.profile_id).name,
      image: user.image.attached? ?  url_for(user.image) : "none",
      active: user.active ? true : false,
      profile_id: user.profile_id,
      created_at: user.created_at,
      updated_at: user.updated_at
    }
  end

  def user_params
     params.require(:user).permit(:name, :email, :profile_id, :active, :image)
  end

  def set_user
     @user = User.find_by(id: params[:id])
  end
end
