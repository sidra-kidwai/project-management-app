# frozen_string_literal: true

class Payment < ApplicationRecord
  paginates_per DEFAULT_PER_PAGE
  belongs_to :project
  delegate :client, to: :project

  validates :amount, presence: true, numericality: true
  validates :payment_date, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :current_month, lambda {
    where('payment_date BETWEEN ? AND ?', current_month_start,
          current_month_end)
  }

  def self.check_monthly_earning
    joins(:project).group('projects.id')
                   .current_month
                   .order('payment_sum DESC')
                   .limit(5)
                   .pluck('projects.name, sum(payments.amount) as payment_sum')
  end
end
