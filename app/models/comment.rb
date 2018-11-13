# frozen_string_literal: true

class Comment < ApplicationRecord
  paginates_per FIVE_PER_PAGE
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
