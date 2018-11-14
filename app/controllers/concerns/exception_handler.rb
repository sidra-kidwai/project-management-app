# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :unauthorized_request
    rescue_from ExceptionHandler::AuthenticationError,
                with: :unauthorized_request
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    rescue_from(ActionController::ParameterMissing) \
      do |parameter_missing_exception|
      error = {}
      error[parameter_missing_exception.param] = ['parameter is required']
      response = { errors: [error] }
      render json: response, status: :unprocessable_entity
    end
  end

  private

  def four_twenty_two(error)
    render json: { errors: [{ message: error.message }] },
           status: :unprocessable_entity
  end

  def unauthorized_request(error)
    render json: { errors: [{ message: error.message }] }, status: :unauthorized
  end

  def record_not_found(error)
    render json: { errors: [{ message: error.message }] }, status: :not_found
  end
end
