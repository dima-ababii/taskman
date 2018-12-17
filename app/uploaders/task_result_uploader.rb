class TaskResultUploader < CarrierWave::Uploader::Base
  # Changed store dir for production
  storage :file
  
  def store_dir
    "#{Rails.root}/lib/tasks/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
