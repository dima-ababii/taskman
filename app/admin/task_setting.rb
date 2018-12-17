ActiveAdmin.register TaskSetting do
  permit_params :max_quantity_for_users
  
  config.clear_action_items!
  
  index do
    column :id
    column :max_quantity_for_users
    actions
  end
  
  form do |f|
    f.inputs do
      f.input :max_quantity_for_users
    end
    f.actions
  end
end
