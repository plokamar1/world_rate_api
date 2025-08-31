# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  state      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint           not null
#
# Indexes
#
#  index_cities_on_country_id           (country_id)
#  index_cities_on_country_id_and_name  (country_id,name) UNIQUE
#  index_cities_on_state                (state)
#
require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe City, type: :model do
  # before do
  #   # Do nothing
  # end
  #
  # after do
  #   # Do nothing
  # end

  describe "validations" do
    subject { build(:city) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:country_id) }
  end

  describe "associations" do
    subject { build(:city) }

    it { should belong_to(:country) }
    it { should have_and_belong_to_many(:reviews) }
  end
end
