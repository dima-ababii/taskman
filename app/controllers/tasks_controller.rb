class TasksController < InheritedResources::Base

  private

    def task_params
      params.require(:task).permit(:title, :status, :description, :file, :file_hex)
    end
end

