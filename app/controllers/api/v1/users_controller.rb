# frozen_string_literal: true

class Api::V1::UsersController < ApiController
  before_action :authenticate_with_token!

  def show
    respond_with User.find_by!(id: params.require(:id))
  end
end
