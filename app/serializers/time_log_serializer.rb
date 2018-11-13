# frozen_string_literal: true

class TimeLogSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :hours_spent, :user_name

  def hours_spent
    object.hours_spent
  end

  def user_name
    object.user.name
  end
end
