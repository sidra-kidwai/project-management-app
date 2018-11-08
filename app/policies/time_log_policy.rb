# frozen_string_literal: true

class TimeLogPolicy < ApplicationPolicy
  def new?
    @user.user?
  end

  def create?
    new?
  end

  def edit?
    new? && @user.id == time_log.user_id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  private

  def time_log
    record
  end
end
