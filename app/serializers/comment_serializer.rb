# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :content, :username

  def username
    object.user.name
  end
end
