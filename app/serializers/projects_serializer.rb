# frozen_string_literal: true

class ProjectsSerializer < ActiveModel::Serializer
  attributes :id, :name, :details
end
