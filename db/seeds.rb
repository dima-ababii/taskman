AdminUser.create!(email: 'taskman_admin@sumdu.com', password: '123123', password_confirmation: '123123') unless Rails.env.production?

User.create!(email: 'admin@mail.com', password: '123123', password_confirmation: '123123', role: 'teacher', first_name: 'admin', last_name: 'admin') unless Rails.env.production?

User.create!(email: 'mail@mail.com', password: '123123', password_confirmation: '123123', role: 'student', first_name: 'Dima', last_name: 'Ababiy') unless Rails.env.production?
User.create!(email: 'vader@mail.com', password: '123123', password_confirmation: '123123', role: 'student', first_name: 'Vader', last_name: 'Dart') unless Rails.env.production?
User.create!(email: 'obi@mail.com', password: '123123', password_confirmation: '123123', role: 'student', first_name: 'Kenobi', last_name: 'ObiVan') unless Rails.env.production?
User.create!(email: 'mol@mail.com', password: '123123', password_confirmation: '123123', role: 'student', first_name: 'Mol', last_name: 'Dart') unless Rails.env.production?
User.create!(email: 'windu@mail.com', password: '123123', password_confirmation: '123123', role: 'student', first_name: 'Windu', last_name: 'Magister') unless Rails.env.production?

TaskSetting.get_task_settings
