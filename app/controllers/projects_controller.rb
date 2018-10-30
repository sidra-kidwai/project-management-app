class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
    authorize @projects
  end

  def show
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
      redirect_to @project, notice: "Project was successfully created!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Update successful!"
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to project_path, notice: "Project destroyed!"
  end

  private

  def find_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:name, :details, :client_id, user_ids: [], attachments_attributes: [:id, :file, :_destroy])
  end
end
