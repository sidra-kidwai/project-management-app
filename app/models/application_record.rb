# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.current_month_start
    Time.zone.now.beginning_of_month
  end

  def self.current_month_end
    Time.zone.now.end_of_month
  end
end
