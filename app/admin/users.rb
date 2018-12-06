ActiveAdmin.register User do
  permit_params :email, :first_name, :password, :password_confirmation, :last_name, :role
  
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  
  controller do
    def update
      model = :user
      if params[model][:password].blank?
        %w(password password_confirmation).each { |p| params[model].delete(p) }
      end
      super
    end
  end
  
  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :role
    column :created_at
    actions
  end
  
  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :role, as: :select, collection: User::ROLES, include_blank: false
    end
    f.actions
  end

end
