# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :find_client, only: %i[show edit update destroy]

  def index
    @clients = Client.latest.page(params[:page]).per(10)
    authorize Client
  end

  def show; end

  def new
    @client = Client.new
    @client.projects.build
    authorize @client
  end

  def create
    @client = Client.new(client_params)
    authorize @client
    if @client.save
      redirect_to @client, success: 'Client was successfully created!'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @client.update(client_params)
      redirect_to @client, success: 'Update successful!'
    else
      render 'edit'
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_path, alert: 'Client destroyed!'
  end

  private

  def find_client
    @client = Client.find(params[:id])
    authorize @client
  end

  def client_params
    params.require(:client).permit(:name, :description, projects_attributes: %i[id name details _destroy])
  end
end
