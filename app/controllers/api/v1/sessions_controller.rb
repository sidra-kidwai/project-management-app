# frozen_string_literal: true

class Api::V1::SessionsController < ApiController
  def create
    user = User.find_by!(email: session_params[:email])
    raise ExceptionHandler::AuthenticationError, 'Invalid Password' unless user&.valid_password?(session_params[:password])

    sign_in user, store: false
    user.generate_authentication_token!
    user.save!
    render json: user, status: 200, location: [:api, :v1, user], serializer: UserSessionSerializer
  end

  def destroy
    user = User.find_by!(auth_token: params.require(:id))
    user.generate_authentication_token!
    user.save!
    head 204
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
