# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :find_project, only: %i[show edit update destroy]

  def index
    @projects = Project.latest.page(params[:page])
    authorize Project
  end

  def show
    @comments = @project.comments.includes(:user).page(params[:comment_page])
    @time_logs = @project.time_logs.includes(:user).page(params[:time_log_page])
  end

  def new
    @project = Project.new
    @project.attachments.build
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project

    if @project.save
      redirect_to @project, success: 'Project was successfully created!'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to @project, success: 'Update successful!'
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to project_path, alert: 'Project destroyed!'
  end

  private

  def find_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:name, :details, :client_id, user_ids: [], attachments_attributes: %i[id file _destroy])
  end
end
