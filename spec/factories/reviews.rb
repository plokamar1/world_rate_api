# frozen_string_literal: true

# == Schema Information
#
# Table name: reviews
#
#  id                    :bigint           not null, primary key
#  days_visited          :integer          not null
#  description           :text             not null
#  food_rating           :integer          default(0)
#  nightlife_rating      :integer          default(0)
#  safety_rating         :integer          default(0)
#  total_expenses        :integer          default(100)
#  total_rating          :float
#  transportation_rating :integer          default(0)
#  weight                :float
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  country_id            :bigint
#  user_id               :bigint
#
# Indexes
#
#  index_reviews_on_country_id              (country_id)
#  index_reviews_on_country_id_and_user_id  (country_id,user_id) UNIQUE
#  index_reviews_on_user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  enum_values = [ 100, 500, 1000, 2000, 5000 ]
  factory :review do
    country
    user
    days_visited { Random.rand(1..100) }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    total_expenses { enum_values[Random.rand(0..enum_values.size)] }
    food_rating { Random.rand(1..10) }
    nightlife_rating { Random.rand(1..10) }
    transportation_rating { Random.rand(1..10) }
    safety_rating { Random.rand(1..10) }
  end
end
