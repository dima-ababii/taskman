FactoryBot.define do
  factory :task_setting do
    max_quantity_for_users { Faker::Number.between(20, 30) }
  end
end
