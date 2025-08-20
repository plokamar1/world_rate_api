# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    country
    user
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    culture_rating { Random.rand(10) }
    expenses_rating { Random.rand(10) }
    food_rating { Random.rand(10) }
    nightlife_rating { Random.rand(10) }
    transportation_rating { Random.rand(10) }
  end
end