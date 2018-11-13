# frozen_string_literal: true

class TimeLog < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :starting_time, presence: true
  validates :ending_time, presence: true
  validate :check_start_time,
           :check_ending_time

  scope :current_month_logs, lambda {
    where(
      '(starting_time BETWEEN ? AND ?) AND (ending_time BETWEEN ? AND ?)',
      current_month_start, current_month_end, current_month_start, current_month_end
    )
  }

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

  def self.check_monthly_hours
    joins(:project).group('projects.id')
                   .current_month_logs
                   .order('hours_sum DESC')
                   .limit(5)
                   .pluck('projects.name, sum(HOUR(TIMEDIFF(time_logs.ending_time, time_logs.starting_time))) as hours_sum')
  end
end
