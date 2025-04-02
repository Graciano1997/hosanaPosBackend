class Api::ProfilesController < ApplicationController
  def index
    @profiles=Profile.all.order(id: :asc)
    render json: { success: true, data: @profiles }, status: :ok
  end
end
