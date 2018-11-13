# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_project, only: %i[index new create edit update destroy]
  before_action :set_payment, only: %i[edit update destroy]

  def index
    @payments = @project.payments.page(params[:page])
    authorize Payment
  end

  def new
    @payments = @project.payments.recent.limit(5)
    @payment = @project.payments.new
    authorize @payment
  end

  def create
    @payment = @project.payments.new(payment_params)
    authorize @payment
    @payment.save
  end

  def edit; end

  def update
    @payment.update(payment_params)
  end

  def destroy
    @payment.destroy
    redirect_to project_payments_path, alert: 'Payment destroyed!'
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
    authorize @payment
  end

  def set_project
    @project = Project.find(params[:project_id])
    authorize @project, :show?
  end

  def payment_params
    params.require(:payment).permit(:amount, :payment_date)
  end
end
