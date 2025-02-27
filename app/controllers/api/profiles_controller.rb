class Api::ProfilesController < ApplicationController
  def index
    @profiles=Profile.all
    render json: { success: true, data: @profiles }, status: :ok
  end
end
