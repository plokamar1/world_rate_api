# frozen_string_literal: true

FactoryBot.define do
  factory :country do
    name { "Greece" }
    code { "GR" }
    rating { 0 }
    reviews_count { 0 }

    # Traits for variations
    # trait :admin do
    #   role { 'admin' }
    # end
    #
    # trait :with_reviews do
    #   after(:create) do |user|
    #     create_list(:review, 3, country: country)
    #   end
    # end
  end
end