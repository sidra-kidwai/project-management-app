# frozen_string_literal: true

class Api::V1::SessionsController < ApiController
  def create
    user_password = session_params[:password]
    user_email = session_params[:email]
    puts session_params
    user = User.find_by!(email: user_email)
    raise ExceptionHandler::AuthenticationError, 'Incorrect Email or Password' unless user&.valid_password?(user_password)

    sign_in user, store: false
    user.generate_authentication_token!
    user.save
    render json: user, status: 200, location: [:api, :v1, user], serializer: UserSessionSerializer
  end

  def destroy
    user = User.find_by!(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
