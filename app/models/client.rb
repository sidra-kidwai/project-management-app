# frozen_string_literal: true

class Client < ApplicationRecord
  paginates_per DEFAULT_PER_PAGE
  has_many :projects, dependent: :destroy

  accepts_nested_attributes_for :projects, reject_if: :all_blank,
                                           allow_destroy: true

  validates :name, presence: true
end
