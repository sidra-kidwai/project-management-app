# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users = User.search(params[:search]).page(params[:page])
  end

  def show; end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
