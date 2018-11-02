class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
