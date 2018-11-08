# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @projects = Project.total_earning
    @top_five = @projects.first(5)
    @last_five = @projects.last(5).reverse
    @total_monthly_hours = TimeLog.check_monthly_hours
    @total_monthly_earning = Payment.check_monthly_earning
  end
end
