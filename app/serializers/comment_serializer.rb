# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :content, :user_name

  def user_name
    object.user.name
  end
end
