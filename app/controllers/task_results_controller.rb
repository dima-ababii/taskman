class TaskResultsController < ApplicationController
  # Authorization
  load_and_authorize_resource
  skip_authorize_resource only: [:show, :new, :edit, :create, :update, :download]
  
  # Set Task
  before_action :set_task_result, only: [:show, :edit, :update, :destroy, :download]
  
  # GET /task_results
  def index
    if params[:page]
      page_number = params[:page]
    else
      page_number = 1
    end
    
    @task_results = TaskResult.all.order(updated_at: :desc).page(page_number)
  end
  
  # GET /task_results/:id
  def show
  
  end
  
  # GET /task_results/new
  def new
    @task_result = TaskResult.new
  end
  
  # GET /task_results/edit/:id
  def edit
    
  end
  
  # POST /task_results/:task_id
  def create
    task = Task.find_by(id: params[:task_id])
    
    if task.nil?
      flash[:alert] = "You try to create Answer for Task that do not exists"
      redirect_to tasks_path
      return
    end
    
    @task_result = TaskResult.new(task_result_params)
    @task_result.task = task
    @task_result.user = current_user
    if @task_result.save
      redirect_to task_path(params[:task_id])
    else
      render 'new', task_id: params[:task_id]
    end
  end
  
  # PUT/PATCH /task_results/:id
  def update
    if @task_result.update(task_result_params)
      redirect_to @task_result.task
    else
      render 'edit'
    end
  end
  
  # DELETE /task_results/:id
  def destroy
    @task_result.destroy
    redirect_to task_results_path
  end
  
  # GET /task_results/:id/download
  def download
    file_path = @task_result.file&.url
    
    if file_path.nil?
      flash[:alert] = "There is no attachments for this task"
      redirect_to task_result_path(@task_result)
      return
    end
    
    send_file(file_path, filename: @task_result.file_name)
  end
  
  private
    def set_task_result
      @task_result = TaskResult.find(params[:id])
    end
    
    def task_result_params
      params.require(:task_result).permit(:description, :file)
    end
end
