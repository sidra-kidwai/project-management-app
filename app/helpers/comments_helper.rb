module CommentsHelper
  def edit_delete_button(commentable, comment)
    unless action_name == 'new' || action_name == 'create'
      capture do
        concat link_to(fa_icon('pencil'), edit_polymorphic_path([commentable, comment]), remote: true, class: "btn-xs btn-warning") if (policy(comment).edit?)
        concat " "
        concat link_to(fa_icon('trash'), [commentable, comment], method: :delete, data: { confirm: "Are you sure?" }, class: "btn-xs btn-danger") if policy(comment).destroy?
      end
    end
  end
end
