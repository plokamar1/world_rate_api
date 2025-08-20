# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 5..10) }
    association :nationality, factory: :country
    association :residence_country, factory: :country

    # Traits for variations
    # trait :admin do
    #   role { 'admin' }
    # end
    #
    trait :with_reviews do
      after(:create) do |user|
        create_list(:review, 3)
      end
    end
  end
end