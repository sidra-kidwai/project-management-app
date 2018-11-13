# frozen_string_literal: true

class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :amount, :payment_date

  def payment_date
    object.payment_date.strftime('%d %B %Y')
  end
end
