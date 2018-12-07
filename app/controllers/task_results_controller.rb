class TaskResultsController < ApplicationController
  # Authorization
  
  # Set Task
  before_action :set_task_result, only: [:show, :edit, :update, :destroy]
  
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
    @task_result = Task.new(task_result_params)
    @task_result
    if @task_result.save
      
    else
      
    end
  end
  
  # PUT/PATCH /task_results/:id
  def update
    
  end
  
  # DELETE /task_results/:id
  def destroy
  
  end
  
  
  private
    def set_task_result
      @task_result = TaskResult.find(params[:id])
    end
    
    def task_result_params
      params.require(:task_result).permit(:description, :file)
    end
end
