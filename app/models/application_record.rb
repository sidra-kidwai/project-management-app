# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  DEFAULT_PER_PAGE = 10
  FIVE_PER_PAGE = 5
  scope :latest, ->(column = :created_at) { order(column => :desc) }

  def self.current_month_start
    Time.zone.now.beginning_of_month
  end

  def self.current_month_end
    Time.zone.now.end_of_month
  end
end
