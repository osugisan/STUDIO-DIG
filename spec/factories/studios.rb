FactoryBot.define do
  factory :studio do
    name { Faker::Lorem.characters(number:10) }
    address { Faker::Lorem.characters(number:10) }
    explanation { Faker::Lorem.characters(number:30) }
    url {  Faker::Internet.unique.url  }
    association :user
  end

  factory :studio_map do
    name { Faker::Lorem.characters(number:10) }
    address { Faker::Address.name }
    explanation { Faker::Lorem.characters(number:30) }
    url {  Faker::Internet.unique.url  }
    association :user
  end
end