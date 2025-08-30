# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id            :bigint           not null, primary key
#  calculated    :boolean          default(TRUE), not null
#  code          :string           not null
#  name          :string           not null
#  rating        :float            default(0.0), not null
#  reviews_count :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe Country, type: :model do
  # before do
  #   # Do nothing
  # end
  #
  # after do
  #   # Do nothing
  # end

  describe "validations" do
    subject { build(:country) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:calculated) }
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:reviews_count) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:code) }
  end

  describe "associations" do
    subject { build(:country) }

    it { should have_many(:reviews) }
    it { should have_many(:residents) }
    it { should have_many(:natives) }
  end

  describe "counters" do
    subject { build(:country) }

    it "updates the reviews_count when reviews get created" do
      user = create(:user)
      create(:review, user: user, country: subject)
      expect(subject.reviews_count).to eq(Review.where(country_id: subject.id).size)
    end
  end
end
