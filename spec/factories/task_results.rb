FactoryBot.define do
  factory :task_result do
    file { Faker::Lorem.characters(10) }
    file_hex { Faker::Lorem.characters(10) }
    description { Faker::Lorem.characters(10) }
  end
end
