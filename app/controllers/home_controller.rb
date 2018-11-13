# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @top_five = Project.top_five_earnings
    @last_five = Project.last_five_earnings
    @total_monthly_hours = TimeLog.check_monthly_hours
    @total_monthly_earning = Payment.check_monthly_earning
  end
end
