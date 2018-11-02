class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: [:destroy, :edit, :update]

  def index
    @comments = @commentable.comments
  end

  def new
    @comments = @commentable.comments.recent.limit(5)
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(comment_params.merge(user_id: current_user.id))
    @comment.save
  end

  def edit
  end

  def update
    @comment.update(comment_params)
    redirect_to @commentable, success: "Comment Updated"
  end

  def destroy
    @comment.destroy
    redirect_to @commentable, alert: "Comment deleted!"
  end

private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
