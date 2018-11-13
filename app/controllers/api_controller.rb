# frozen_string_literal: true

class ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  respond_to :json

  include Authenticable
  include ExceptionHandler

  def not_found
    json = {
      url: request.url,
      message: "Request method '#{request.method}' not supported"
    }

    render json: json, status: :not_found
  end
end
