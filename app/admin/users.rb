# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :name, :email, :active, :role

  index do
    render 'admin/users/user', context: self
  end

  form partial: 'form'

  member_action :change_user_state, method: :put do
    update_user_state
  end

  member_action :update_role, method: :put do
    change_user_role
  end

  member_action :create, method: :post do
    create_user_by_admin
  end

  action_item :change_user_state, only: :show do
    change_user_state_button(user)
  end

  action_item :update_role, only: :show do
    update_role_button(user)
  end
end

def update_user_state
  @user = User.find(params[:id])
  @user.update(active: !@user.active)
  redirect_to resource_path, notice: 'Status Changed!'
end

def change_user_role
  @user = User.find(params[:id])
  if @user.manager?
    @user.user!
    notice = 'User demoted!'
  elsif @user.user?
    @user.manager!
    notice = 'User promoted!'
  end
  redirect_to resource_path, notice: notice
end

def create_user_by_admin
  password_length = 6
  @password = Devise.friendly_token(password_length)
  @user = User.create(permitted_params[:user]
              .merge(password: @password, password_confirmation: @password))
  if @user
    @user.send_reset_password_instructions
    redirect_to admin_users_path, notice: 'User successfully created!'
  else
    redirect_to admin_users_path, alert: 'User could not be saved!'
  end
end

def update_role_button(user)
  if user.admin? || user.manager?
    link_to 'Demote', update_role_admin_user_path(user), method: :put
  else
    link_to 'Promote', update_role_admin_user_path(user), method: :put
  end
end

def change_user_state_button(user)
  return if user.admin?

  link_to 'Enable/disable user', change_user_state_admin_user_path(user),
          method: :put
end
