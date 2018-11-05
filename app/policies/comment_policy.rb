class CommentPolicy < ApplicationPolicy

  def create?
    @user.user?
  end

  def new?
    @user.user?
  end

  def edit?
    @user == comment.user
  end

  def update?
    @user == comment.user
  end

  def destroy?
    @user == comment.user
  end

  private

  def comment
    record
  end

end
