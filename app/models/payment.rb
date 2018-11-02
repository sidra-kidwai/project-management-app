class Payment < ApplicationRecord
  belongs_to :project
  delegate :client, to: :project

  validates :amount, presence: true, numericality: true

  scope :recent, -> { order(created_at: :desc) }

end
