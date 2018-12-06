class UsersController < ApplicationController
  load_and_authorize_resource
  
  # GET /users
  def index
    if current_user.role == 'teacher'
      @users = User.all
    else
      @users = User.where(id: current_user.id)
    end
  end
  
  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end
end
