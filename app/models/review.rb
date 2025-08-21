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
  attr_readonly :total_rating
  ##
  # Associations
  belongs_to :country, counter_cache: true
  belongs_to :user, counter_cache: true

  ##
  # Validations
  validates :description, length: { maximum: 500 }
  validates_uniqueness_of :user_id, scope: [:country_id]
  validates :culture_rating, :expenses_rating, :food_rating, :nightlife_rating, :transportation_rating,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }, allow_nil: true
  validates :total_rating,
            numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }

  ##
  # Callbacks
  before_validation :calculate_total_rating
  after_commit :set_calculated_to_false

  private

    def set_calculated_to_false
      country.update(calculated: false)
    end

    def calculate_total_rating
      ratings = [culture_rating, expenses_rating, food_rating, nightlife_rating, transportation_rating]
                  .keep_if { |r| r.present? }
      return if ratings.empty?

      sum = ratings.sum
      self.total_rating = sum / ratings.size
    end

end
