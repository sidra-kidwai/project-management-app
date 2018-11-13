# frozen_string_literal: true

class Api::V1::ProjectsController < ApiController
  before_action :authenticate_with_token!

  def show
    respond_with Project.find(params[:id])
  end

  def index
    respond_with Project.search(params[:search]), each_serializer: ProjectsSerializer
  end
end
