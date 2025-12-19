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
    it { should validate_uniqueness_of(:email) }
    it { should_not allow_value("test_com").for(:email) }
    it { should_not allow_value("test.com").for(:email) }
    it { should allow_value("test_test@test.com").for(:email) }
    it { should define_enum_for(:gender).with_values([ :female, :male, :transgender ]) }
  end

  describe "associations" do
    subject { build(:user) }

    it { should have_many(:reviews) }
    it { should belong_to(:nationality).optional }
    it { should belong_to(:residence_country).optional }
  end

  describe "counters" do
    it "updates the reviews_count when reviews get created" do
      user = create(:user, :with_reviews)
      expect(user.reviews_count).to eq(user.reviews.size)
    end
  end
end
