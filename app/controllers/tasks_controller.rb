class TasksController < ApplicationController
  # Authorization
  load_and_authorize_resource
  skip_authorize_resource only: [:assign, :unassign, :download, :change_state]
  
  # Set Task
  before_action :set_task, only: [:show, :edit, :update, :destroy, :assign, :deassign, :download]
  
  # GET /tasks
  def index
    if params[:page]
      page_number = params[:page]
    else
      page_number = 1
    end
    
    @tasks = Task.all.order(updated_at: :desc).page(page_number)
  end
  
  # GET /tasks/:id
  def show
    current_assignment = TasksUser.find_by(task: @task, user: current_user, unassigned_at: nil)
    
    assignment_user_ids = TasksUser.where(task: @task, unassigned_at: nil).pluck(:user_id)
    assign_users = User.where(id: assignment_user_ids).order(is_active: :desc)
    
    @data = {
      task: @task,
      is_assign: current_assignment.present?,
      curret_state: current_assignment&.state,
      current_user: current_user,
      assign_users: assign_users
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
    
    task_user = TasksUser.new(task: @task, user: current_user)
    if task_user.save
      flash[:notice] = "#{@task.title} task was assigned"
    else
      flash[:notice] = "#{@task.errors.full_messages}"
    end
    redirect_to task_path(@task)
  end
  
  # GET /task/:id/unassign
  def unassign
    task_user = TasksUser.find_by(task: @task, user: current_user, unassigned_at: nil)
    
    if task_user.nil?
      flash[:alert] = "Task can not be unassigned"
      redirect_to tasks_path
      return
    end
    
    task_user.unassigned_at = DateTime.current
    if task_user.save
      flash[:notice] = "#{@task.title} task was unassigned"
    else
      flash[:alert] = "#{@task.errors.full_messages}"
    end
    
    redirect_to task_path(@task)
  end
  
  # POST /tasks/:id/change_state/:state
  def change_state
    state_param = params[:state]
    task_param = params[:id]
    
    task_user = TasksUser.find_by(task_id: task_param, user: current_user, unassigned_at: nil)
    task_user.update(state: state_param)
    
    flash[:notice] = "The state was changed to #{state_param&.humanize}"
    redirect_to task_path(task_param)
  end
  
  # GET /tasks/:id/download
  def download
    file_path = @task.file&.url
    
    if file_path.nil?
      flash[:alert] = "There is no attachments for this task"
      redirect_to task_path(@task)
      return
    end
    
    send_file(file_path, filename: @task.file_name)
  end
  
  private
    def set_task
      @task = Task.find(params[:id])
    end
    
    def task_params
      params.require(:task).permit(:expiration_date, :title, :status, :description, :file, user_ids: [])
    end
end
