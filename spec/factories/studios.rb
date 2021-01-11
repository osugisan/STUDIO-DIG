FactoryBot.define do
  factory :studio do
    name { Faker::Lorem.characters(number:10) }
    address { "埼玉県鴻巣市小谷1945" }
    explanation { Faker::Lorem.characters(number:30) }
    url { "https://studio--dig.com/" }
    association :user
  end
end