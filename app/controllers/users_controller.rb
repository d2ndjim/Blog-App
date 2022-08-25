class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def api_show
    @posts = User.find(params[:id]).posts
    render json: { data: @posts }, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
