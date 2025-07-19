class Api::ProfilesController < ApplicationController
  def index
    @profiles=Profile.all.order(id: :asc)
    render json: { success: true, data: @profiles }, status: :ok
  end

  def init
    Profile.create!(name: "master")
    Profile.create!(name: "operator")
    User.create!(name:"admin",email:"admin@admin.com",profile_id:1,active:true,password:"admin")
    render json: { success: true, message: "created sucessfuly" }
   end
end
