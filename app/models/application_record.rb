# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :latest, ->(column = :created_at) { order(column => :desc) }

end
