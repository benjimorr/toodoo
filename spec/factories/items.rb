FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(15) }
    complete false
    todo
  end
end
