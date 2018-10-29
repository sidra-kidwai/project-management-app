class ClientsController < ApplicationController

  before_action :find_client, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_manager!, only: [:new, :create, :update, :edit, :destroy]

  def index
    @clients = Client.all
  end

  def show
  end

  def new
    @client = Client.new
    @client.projects.build
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client, notice: "Client was successfully created!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to @client, notice: "Update successful!"
    else
      render 'edit'
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_path, notice: "Client destroyed!"
  end

  private

  def find_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :description, projects_attributes: [:id, :name, :details, :_destroy])
  end
end
