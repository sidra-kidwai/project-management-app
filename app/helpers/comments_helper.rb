module CommentsHelper
  def comment_edit_button(commentable, comment)
    return if action_name.in?(['new', 'create'])
    link_to fa_icon('pencil'), edit_polymorphic_path([commentable, comment]), remote: true, class: "btn-xs btn-warning" if policy(comment).edit?
  end

  def comment_delete_button(commentable, comment)
    return if action_name.in?(['new', 'create'])
    link_to fa_icon('trash'), [commentable, comment], method: :delete, data: { confirm: "Are you sure?" }, class: "btn-xs btn-danger" if policy(comment).destroy?
  end
end
