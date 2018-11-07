# frozen_string_literal: true

module CommentsHelper
  def comment_edit_button(commentable, comment)
    return if action_name.in?(%w[new create])

    link_to fa_icon('pencil'), edit_polymorphic_path([commentable, comment]), remote: true, class: 'btn-xs btn-warning' if policy(comment).edit?
  end

  def comment_delete_button(commentable, comment)
    return if action_name.in?(%w[new create])

    link_to fa_icon('trash'), [commentable, comment], method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn-xs btn-danger' if policy(comment).destroy?
  end

  def comment_new_button(commentable)
    link_to (fa_icon 'comments', text: 'New Comment'), new_project_comment_path(commentable), remote: true, class: 'btn btn-primary btn-xs' if policy(Comment).new?
  end
end
