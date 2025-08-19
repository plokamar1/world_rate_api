# == Schema Information
#
# Table name: reviews
#
#  id                    :bigint           not null, primary key
#  culture_rating        :integer          default(0)
#  description           :text
#  expenses_rating       :integer          default(0)
#  food_rating           :integer          default(0)
#  nightlife_rating      :integer          default(0)
#  total_rating          :float
#  transportation_rating :integer          default(0)
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
class Review < ApplicationRecord
  belongs_to :country, counter_cache: true
  belongs_to :user, counter_cache: true
end
