# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[destroy edit update]

  def index
    @comments = @commentable.comments.page(params[:page])
    authorize @comments
  end

  def new
    @comments = @commentable.comments.recent.limit(5)
    @comment = @commentable.comments.new
    authorize @comment
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    authorize @comment
    @comment.save
  end

  def edit; end

  def update
    @comment.update(comment_params)
    redirect_to @commentable, success: 'Comment Updated'
  end

  def destroy
    @comment.destroy
    redirect_to @commentable, alert: 'Comment deleted!'
  end

  private

  def commentable_class
    params.each do |key, _value|
      if /(.+)_id$/.match?(key)
        model = key.match(%r{([^\/.]+)_id$})
        return model[1].classify.constantize, key
      end
    end
    nil
  end

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def set_commentable
    klass, param = commentable_class
    @commentable = klass.find(params[param.to_sym]) if klass
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
