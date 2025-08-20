# frozen_string_literal: true

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
  end

  describe "associations" do
    subject { build(:country) }

    it { should have_many(:reviews) }
    it { should have_many(:residents) }
    it { should have_many(:natives) }
  end
end
