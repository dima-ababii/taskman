class TaskSetting < ApplicationRecord
  # Fields validations
  validates :max_quantity_for_users, presence: true
  
  private
    def self.get_task_settings
    task_settings = TaskSetting.first
    if task_settings.nil?
      params = {
        max_quantity_for_users: 20
      }
      task_settings = TaskSetting.create(params)
    end
    return task_settings
  end
end
