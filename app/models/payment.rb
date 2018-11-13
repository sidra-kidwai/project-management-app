# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :project
  delegate :client, to: :project

  validates :amount, presence: true, numericality: true
  validates :payment_date, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def self.check_monthly_earning
    joins(:project).group('projects.id')
                   .where('payment_date BETWEEN ? AND ?', Time.now.beginning_of_month, Time.now.end_of_month)
                   .order('payment_sum DESC')
                   .limit(5)
                   .pluck('projects.name, sum(payments.amount) as payment_sum')
  end
end
