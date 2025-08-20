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
      transient do
        review_country { nil }
        review_count { 3 }
      end
      after(:create) do |user, evaluator|
        if (country = evaluator.review_country).present?
          create(:review, user: user, country: country)
        else
          create_list(:review, evaluator.review_count, user: user)
        end
      end
    end
  end
end