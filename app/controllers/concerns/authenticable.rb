# frozen_string_literal: true

module Authenticable
  def current_user
    @current_user ||= User.find_by(auth_token:
                                    request.headers['Authorization'])
  end

  def authenticate_with_token!
    return if current_user.present?

    render json: { errors: 'Not authenticated' }, status: :unauthorized
  end

  def user_signed_in?
    current_user.present?
  end
end
