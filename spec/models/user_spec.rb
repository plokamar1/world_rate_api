# frozen_string_literal: true

require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe User, type: :model do
  # before do
  #   # Do nothing
  # end
  #
  # after do
  #   # Do nothing
  # end

  describe "validations" do
    subject { build(:user) }

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:reviews_count) }
    it { should validate_uniqueness_of(:username) }
  end

  describe "associations" do
    subject { build(:user) }

    it { should have_many(:reviews) }
    it { should belong_to(:nationality) }
    it { should belong_to(:residence_country) }
  end

  describe "counters" do
    it "updates the reviews_count when reviews get created" do
      user = create(:user, :with_reviews)
      expect(user.reviews_count).to eq(user.reviews.size)
    end
  end
end
