class TasksController < InheritedResources::Base
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
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
  
  private
    def set_task
      @task = Task.find(params[:id])
    end
    
    def task_params
      params.require(:task).permit(:title, :status, :description, :file, :file_hex)
    end
end
