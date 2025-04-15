class Api::ProfilesController < ApplicationController
  def index
    @profiles=Profile.all.order(id: :asc)
    render json: { success: true, data: @profiles }, status: :ok
  end

  def init
    Profile.create!(name: "master")
    Profile.create!(name: "operator")
    render json: { success: true, message: "created sucessfuly" }
  end
end
