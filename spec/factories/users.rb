FactoryBot.define do
  factory :user, aliases: [:following, :follower] do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number:20) }
    password { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      admin { true }
    end
  end
end