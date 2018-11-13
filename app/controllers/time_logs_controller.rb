# frozen_string_literal: true

class TimeLogsController < ApplicationController
  before_action :set_project
  before_action :set_time_log, only: %i[edit update destroy]

  def index
    @time_logs = @project.time_logs.includes(:user).page(params[:page])
    authorize @time_logs
  end

  def new
    @time_logs = @project.time_logs
    @time_log = @project.time_logs.new
    authorize @time_log
  end

  def create
    @time_log = @project.time_logs.new(time_log_params)
    @time_log.user_id = current_user.id
    authorize @time_log
    flash.now[:success] = 'Time-log was successfully added!' if @time_log.save
  end

  def edit; end

  def update
    @time_log.update(time_log_params)
  end

  def destroy
    @time_log.destroy
    redirect_to @project, notice: 'Time-log was successfully destroyed!'
  end

  private

  def set_time_log
    @time_log = TimeLog.find(params[:id])
    authorize @time_log
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def time_log_params
    params.require(:time_log).permit(:starting_time, :ending_time)
  end
end
