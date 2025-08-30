# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  email                :string           not null
#  gender               :integer
#  reviews_count        :integer          default(0), not null
#  username             :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  nationality_id       :bigint
#  residence_country_id :bigint
#
# Indexes
#
#  index_users_on_nationality_id        (nationality_id)
#  index_users_on_residence_country_id  (residence_country_id)
#
# Foreign Keys
#
#  fk_rails_...  (nationality_id => countries.id)
#  fk_rails_...  (residence_country_id => countries.id)
#
FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username(specifier: 5..10) }
    email { Faker::Internet.unique.email }
    traits_for_enum(:gender)
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
