FactoryBot.define do
  factory :review do
    association :user
    association :studio
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:20) }
    rank { 5 }
  end
end