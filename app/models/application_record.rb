# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  PER_PAGE = 10
  FIVE_PER_PAGE = 5
  scope :latest, ->(column = :created_at) { order(column => :desc) }
end
