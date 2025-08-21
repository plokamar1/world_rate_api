# frozen_string_literal: true

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
    it { should validate_comparison_of(:culture_rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10).allow_nil }
    it { should validate_comparison_of(:expenses_rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10).allow_nil }
    it { should validate_comparison_of(:food_rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10).allow_nil }
    it { should validate_comparison_of(:nightlife_rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10).allow_nil }
    it { should validate_comparison_of(:transportation_rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(10).allow_nil }
    it { should have_readonly_attribute(:total_rating) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:country_id) }

  end

  describe "associations" do
    subject { build(:review) }

    it { should belong_to(:user) }
    it { should belong_to(:country) }
  end

  describe "business" do
    it "updates country's calculated attribute" do
      country = create(:country)
      expect { create(:review, country: country) }.to change(country, :calculated)
    end

    it "calculates total_rating before validation" do
      country = create(:country)
      review = create(:review, country: country,
                      culture_rating: 5,
                      expenses_rating: 1,
                      food_rating: 5,
                      nightlife_rating: 1,
                      transportation_rating: 5)
      expect(review.total_rating).to eq(3)
    end
  end
end
