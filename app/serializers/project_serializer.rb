# frozen_string_literal: true

class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :details
  has_many :comments
  has_many :time_logs
  has_many :payments
  has_many :users, through: :project_users
end
