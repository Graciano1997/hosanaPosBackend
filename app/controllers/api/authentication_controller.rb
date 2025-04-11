class Api::AuthenticationController < ApplicationController

   def login
    user = User.find_by_email(params[:email])


    if user && user.authenticate(params[:password])   #Assuming you have bcrypt for password hashing
      token = encode_token(user_id: user.id)
      render json: { user:current_user(user,token)}, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
   end

  private
  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET_KEY'], 'HS256')
  end

  def current_user(user,token)
    {
      id:user.id,
      name:user.name,
      email:user.email,
      profileId:user.profile_id,
      profile: Profile.find(user.profile_id).name,
      active: user.active,
      token:token,
      image: user.image.attached? ?  url_for(user.image) : "none",
    }
  end
end
