# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :client
  has_many :project_users
  has_many :users, through: :project_users, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :time_logs, dependent: :destroy

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true

  def no_of_payments
    payments.count
  end

  def assigned?(user)
    users.where(id: user.id).exists?
  end

  def total_earnings
    payments.sum(:amount).to_f
  end

  def total_logged_hours
    time_logs.sum(&:hours_spent)
  end

  def self.total_earning
    projects = Payment.joins(:project).group(:project).order('sum_amount DESC').sum(:amount)
    projects.map(&:first)
  end
end
