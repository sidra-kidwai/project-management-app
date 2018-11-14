# frozen_string_literal: true

module UsersHelper
  def update_role_button(user)
    if user.admin? || user.manager?
      link_to 'Demote', update_role_admin_user_path(user), method: :put
    else
      link_to 'Promote', update_role_admin_user_path(user), method: :put
    end
  end
end
