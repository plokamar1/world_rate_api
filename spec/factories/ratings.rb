# == Schema Information
#
# Table name: ratings
#
#  id                    :bigint           not null, primary key
#  food_rating           :integer          default(0)
#  nature_rating         :integer          default(0)
#  nightlife_rating      :integer          default(0)
#  ratable_type          :string           not null
#  safety_rating         :integer          default(0)
#  sightseeing_rating    :integer          default(0)
#  total_rating          :float
#  transportation_rating :integer          default(0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  ratable_id            :bigint           not null
#
FactoryBot.define do
  factory :rating do

    food_rating { Random.rand(1..10) }
    nightlife_rating { Random.rand(1..10) }
    transportation_rating { Random.rand(1..10) }
    safety_rating { Random.rand(1..10) }
    nature_rating { Random.rand(1..10) }
    sightseeing_rating { Random.rand(1..10) }

    trait :for_country do
      association :ratable, factory: :country
    end

    trait :for_city do
      association :ratable, factory: :city
    end

  end
end
