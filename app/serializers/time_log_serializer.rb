# frozen_string_literal: true

class TimeLogSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :hours_spent, :username

  def hours_spent
    object.hours_spent
  end

  def username
    object.user.name
  end
end
