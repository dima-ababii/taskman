class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :assign, :deassign, :download]
  
  # GET /tasks
  def index
    @tasks = Task.all
  end
  
  # GET /tasks/:id
  def show
    is_assign = TasksUser.find_by(task: @task, user: current_user, unassigned_at: nil)
    @data = {
      task: @task,
      is_assign: is_assign
    }
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
    # Delete user_ids from task params
    params = task_params
    params.delete(:user_ids)
    
    @task = Task.new(params)
    if @task.save
      flash[:notice] = "#{@task.title} task was created"
      # Assign created Task to Users
      task_params[:user_ids].each do |user_id|
        existing_task_for_user = TasksUser.where(task: @task, user_id: user_id).where.not(unassigned_at: nil).first
        next if existing_task_for_user
        
        # Create Assosiation
        TasksUser.create(task: @task, user_id: user_id)
      end
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
  
  # GET /task/:id/assign
  def assign
    unassigned_tasks_user = TasksUser.find_by(task: @task, user: current_user, unassigned_at: nil)
    if unassigned_tasks_user
      flash[:alert] = "Task can not be assigned"
      redirect_to tasks_path
      return
    end
    
    task_user = TasksUser.new(task_id: params[:id], user: current_user)
    if task_user.save
      flash[:notice] = "#{task_user.task.title} task was assigned"
    else
      flash[:notice] = "#{task_user.task.errors.full_messages}"
    end
    redirect_to tasks_path
  end
  
  # GET /task/:id/unassign
  def unassign
    task_user = TasksUser.find_by(task_id: params[:id], user: current_user, unassigned_at: nil)
    
    if task_user.nil?
      flash[:alert] = "Task can not be unassigned"
      redirect_to tasks_path
      return
    end
    
    task_user.unassigned_at = DateTime.current
    if task_user.save
      flash[:notice] = "#{task_user.task.title} task was unassigned"
    else
      flash[:alert] = "#{task_user.task.errors.full_messages}"
    end
    
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
