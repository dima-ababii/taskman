class UsersController < ApplicationController
  load_and_authorize_resource
  
  # GET /users
  def index
    @users = User.all
  end
  
  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end
end
