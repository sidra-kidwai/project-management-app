# frozen_string_literal: true

class Payment < ApplicationRecord
  paginates_per DEFAULT_PER_PAGE
  belongs_to :project
  delegate :client, to: :project

  validates :amount, presence: true, numericality: true
  validates :payment_date, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
