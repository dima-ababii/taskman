class UsersController < ApplicationController
  load_and_authorize_resource
  
  # GET /users
  def index
    if params[:page]
      page_number = params[:page]
    else
      page_number = 1
    end
    
    if current_user.role == 'teacher'
      users = User.all
    else
      users = User.where(id: current_user.id)
    end
    
    @users = users.page(page_number)
  end
  
  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end
end
