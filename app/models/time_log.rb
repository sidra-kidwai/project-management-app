# frozen_string_literal: true

class TimeLog < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :starting_time, presence: true
  validates :ending_time, presence: true
  validate :check_start_time,
           :check_ending_time

  paginates_per FIVE_PER_PAGE

  def check_start_time
    errors.add(:starting_time, "can't be greater than ending time.") if
    starting_time.present? && ending_time.present? && starting_time > ending_time
  end

  def check_ending_time
    errors.add(:ending_time, "can't be greater than today.") if
    ending_time.present? && ending_time > Time.now
  end

  def hours_spent
    ((ending_time - starting_time) / 1.hour).round
  end
end
