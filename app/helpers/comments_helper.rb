# frozen_string_literal: true

module CommentsHelper
  def comment_edit_button(commentable, comment)
    return if action_name.in?(%w[new create])

    return unless policy(comment).edit?

    link_to fa_icon('pencil'),
            edit_polymorphic_path([commentable, comment]),
            remote: true, class: 'btn-xs btn-warning'
  end

  def data_confirmable
    { confirm: 'Are you sure?' }
  end

  def comment_delete_button(commentable, comment)
    return if action_name.in?(%w[new create])

    return unless policy(comment).destroy?

    link_to fa_icon('trash'), [commentable, comment], method: :delete,
                                                      data: data_confirmable,
                                                      class: 'btn-xs btn-danger'
  end

  def comment_new_button(commentable)
    return unless policy(Comment).new?

    link_to (fa_icon 'comments', text: 'New Comment'),
            new_project_comment_path(commentable),
            remote: true, class: 'btn btn-primary btn-xs'
  end
end
