FactoryBot.define do
    pw = "password"

    factory :user do
        sequence(:name) { |n| "User#{n}" }
        sequence(:email) { |n| "person#{n}@toodoo.com" }
        password pw
        password_confirmation pw
    end
end
