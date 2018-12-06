AdminUser.create!(email: 'taskman_admin@sumdu.com', password: '123123', password_confirmation: '123123') unless Rails.env.production?
