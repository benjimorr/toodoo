FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.characters(10) }
    category { Faker::Lorem.characters(10) }
    user
  end
end
