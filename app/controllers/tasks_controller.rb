class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :download]
  
  # GET /tasks
  def index
    @tasks = Task.all
  end
  
  # GET /tasks/:id
  def show
  end
  
  # GET /tasks/new
  def new
    @task = Task.new
  end
  
  # GET /tasks/edit/:id
  def edit
    
  end
  
  # POST /tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      # assign_task
      redirect_to tasks_path
    else
      render 'new'
    end
  end
  
  # PUT/PATCH /tasks/:id
  def update
    if @task.update(task_params)
      # assign_task
      redirect_to @task
    else
      render 'edit'
    end
  end
  
  # DELETE /tasks/:id
  def destroy
    @task.destroy
    redirect_to tasks_path
  end
  
  # POST /tasks/:id/change_state/:state
  def change_state
    task_user = TasksUser.find_by(task_id: params[:id], user: current_user)
    task_user.update(state: params[:state])
    redirect_to tasks_path
  end
  
  # GET /tasks/:id/download
  def download
    file_path = @task.file&.url
    # notice if file_path nil
    send_file( file_path, filename: @task.file_name)
  end
  
  private
    def set_task
      @task = Task.find(params[:id])
    end
    
    def task_params
      params.require(:task).permit(:title, :status, :description, :file, user_ids: [])
    end
end
