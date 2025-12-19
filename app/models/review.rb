# == Schema Information
#
# Table name: reviews
#
#  id                    :bigint           not null, primary key
#  days_visited          :integer          not null
#  description           :text             not null
#  food_rating           :integer          default(0)
#  nature_rating         :integer          default(0)
#  nightlife_rating      :integer          default(0)
#  safety_rating         :integer          default(0)
#  sightseeing_rating    :integer          default(0)
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
class Review < ApplicationRecord
  # TODO:
  # - Add verification attribute (boolean)
  # - Pass attributes through an AI assistant to check toxicity, racism, bad language
  # - Add attribute that describes if the user found the country expensive (boolean)
  attr_readonly :total_rating, :weight
  ##
  # Associations
  belongs_to :country, counter_cache: true
  belongs_to :user, counter_cache: true
  has_and_belongs_to_many :cities

  ##
  # Validations
  validates :description, length: { maximum: 500 }, presence: true
  validates_uniqueness_of :user_id, scope: [ :country_id ]
  validates :safety_rating, :food_rating, :nightlife_rating, :transportation_rating,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }, allow_nil: true
  validates :total_rating,
            numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :weight, numericality: { greater_than_or_equal_to: 0.1, less_than_or_equal_to: 1.0 }, allow_nil: true
  validates :total_expenses, inclusion: { in: [ 100, 500, 1000, 2000, 5000 ] }, allow_nil: true

  ##
  # Callbacks
  before_validation :calculate_total_rating!
  before_save :calculate_total_weight!
  # TODO: move this to a service
  after_commit :set_calculated_to_false_in_country
  after_commit :set_calculated_to_false_in_cities

  private

    def set_calculated_to_false_in_country
      country.update(calculated: false)
    end

    def set_calculated_to_false_in_cities
      cities.update(calculated: false)
    end

    # Callback
    # calculates total rating of the review
    def calculate_total_rating!
      ratings = [ safety_rating, food_rating, nightlife_rating, transportation_rating ]
                  .keep_if { |r| r.present? }
      return if ratings.empty?

      sum = ratings.sum
      self.total_rating = sum / ratings.size
    end

    # Callback
    # calculates the total weight of the review by fetching data from app configuration
    # The more fields the user has filled in their review the more weight is getting added.
    # This weight will be used to calculate the total review of the country.
    def calculate_total_weight!
      self.weight = Rails.configuration.world_rate.dig(:reviews_weight).sum do |attribute, weight_value|
        self.send(attribute).present? ? weight_value.to_f : 0
      end
    end
end
