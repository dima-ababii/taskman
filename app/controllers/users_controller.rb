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
  
  # POST /users/:id/activation
  def activation
    user = User.find(params[:id])
    
    if user && user != current_user
      flash[:alert] = "Permission denied"
      redirect_to users_path
    end
    
    if user.is_active
      user.update_columns(is_active: false)
      flash[:notice] = "Your account is active"
    else
      user.update_columns(is_active: true)
      flash[:notice] = "Your account is deactive"
    end
  end
end
