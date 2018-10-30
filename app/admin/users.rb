ActiveAdmin.register User do

  permit_params :name, :email, :active, :role

  index do
    id_column
    column :name
    column :email
    column :active
    column :role
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs "User Details" do
      input :name
      input :email
      input :role
    end
    f.actions
  end

  member_action :change_user_state, method: :put do
    @user = User.find(params[:id])
    @user.update(active: !@user.active)
    redirect_to resource_path, notice: "Status Changed!"
  end

  member_action :update_role, method: :put do
    @user = User.find(params[:id])
    if @user.manager?
      @user.user!
      notice = "User demoted!"
    elsif @user.user?
      @user.manager!
      notice = "User promoted!"
    end
    redirect_to resource_path, notice: notice
  end

  member_action :create, method: :post do
    password_length = 6
    @password = Devise.friendly_token(password_length)
    @user = User.create(permitted_params[:user].merge(password: @password, password_confirmation: @password))
    if @user
      @user.send_reset_password_instructions
      redirect_to admin_users_path, notice: "User successfully created!"
    else
      flash[:alert] = "There was a problem processing your request."
      redirect_to admin_users_path
    end
  end

  action_item :change_user_state, only: :show do
    unless user.admin?
      link_to 'Enable/disable user', change_user_state_admin_user_path(user), method: :put
    end
  end

  action_item :update_role, only: :show do
    if user.admin? || user.manager?
      link_to 'Demote', update_role_admin_user_path(user), method: :put
    else
      link_to 'Promote', update_role_admin_user_path(user), method: :put
    end
  end
end
