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
  end

  describe "associations" do
    subject { build(:user) }

    it { should have_many(:reviews) }
    it { should belong_to(:nationality) }
    it { should belong_to(:residence_country) }
  end
end
