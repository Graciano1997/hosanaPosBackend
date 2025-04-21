class ApplicationController < ActionController::API
  include ActionController::Rendering
  include ActionController::Cookies

  def authorize_request
    if header
      token= header.split(" ").last
      begin
        decoded=JWT.decode(token, ENV["JWT_SECRET_KEY"], true, algoritm: "HS256")
        @current_user = User.find(decoded[0]["user_id"])
      rescue JWT::DecodeError
        render json: { error: "Not authorized" }, status: :unauthorized
      end
    else
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end

  def root
    redirect_to rswag_ui_path
  end
end
