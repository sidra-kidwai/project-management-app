# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    true
  end

  def new?
    true
  end

  def edit?
    @user.id == comment.user_id
  end

  def update?
    @user.id == comment.user_id
  end

  def destroy?
    @user.id == comment.user_id
  end

  private

  def comment
    record
  end
end
