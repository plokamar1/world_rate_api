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
require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe Review, type: :model do
  # before do
  #   # Do nothing
  # end
  #
  # after do
  #   # Do nothing
  # end

  describe "validations" do
    subject { build(:review) }

    it { should validate_length_of(:description).is_at_most(500) }
    it { should validate_presence_of(:description) }

    it { should validate_comparison_of(:food_rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10).allow_nil }
    it { should validate_comparison_of(:nightlife_rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10).allow_nil }
    it { should validate_comparison_of(:transportation_rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10).allow_nil }

    it { should validate_inclusion_of(:total_expenses).in_array([ 100, 500, 1000, 2000, 5000 ]).allow_nil }
    it { should have_readonly_attribute(:total_rating) }
    it { should have_readonly_attribute(:weight) }
    it { should validate_comparison_of(:weight).is_greater_than(0).is_less_than_or_equal_to(1) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:country_id) }
  end

  describe "associations" do
    subject { build(:review) }

    it { should belong_to(:user) }
    it { should belong_to(:country) }
    it { should have_and_belong_to_many(:cities) }
  end

  describe "business" do
    it "updates country's calculated attribute" do
      country = create(:country)
      expect { create(:review, country: country) }.to change(country, :calculated)
    end

    it "updates cities calculated attribute" do
      cities = create_list(:city, 2)
      expect { create(:review, cities: cities) }.to change {
        cities.all? { |c| c.calculated == false }
      }
    end

    it "calculates weight before validation" do
      country = create(:country)
      review = create(:review, country: country,
                      safety_rating: _5,
                      food_rating: 5,
                      nightlife_rating: 1,
                      transportation_rating: 5,
                      total_expenses: nil)

      expect(review.weight).not_to be_nil
      expect(review.weight).to be >= 0.1
      expect(review.weight).to be < 1
    end

    it "calculates total_rating before validation" do
      country = create(:country)
      review = create(:review, country: country,
                      safety_rating: _5,
                      food_rating: 5,
                      nightlife_rating: 1,
                      transportation_rating: 5)
      expect(review.total_rating).to eq(3)
    end
  end
end
