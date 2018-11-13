# frozen_string_literal: true

class ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  respond_to :json

  include Authenticable
  include ExceptionHandler
end
