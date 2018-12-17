FactoryBot.define do
  factory :task do
    title { Faker::Lorem.characters(10) }
    description { Faker::Lorem.characters(10) }
    file { Faker::Lorem.characters(10) }
    file_hex { Faker::Lorem.characters(10) }
  end
end
