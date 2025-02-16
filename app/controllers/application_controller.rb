class ApplicationController < ActionController::API
  def root
    redirect_to rswag_ui_path
  end
end
