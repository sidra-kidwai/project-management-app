class Payment < ApplicationRecord
  belongs_to :project
  delegate :client, to: :project

  validates :amount, presence: true, numericality: true
  validates :payment_date, presence: true

  scope :recent, -> { order(created_at: :desc) }

end
