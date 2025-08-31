# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculateCityRatingService do
  let(:city) { create(:city) }
  let(:service) { described_class.new(city) }

  describe "#call" do
    context "when city has reviews" do
      before do
        create(:review, total_rating: 8.0, weight: 0.9, cities: [city])
        create(:review, total_rating: 6.0, weight: 0.8, cities: [city])
      end

      it "calculates and updates the city's total rating" do
        expect(city.rating).to eq(0)
        result = service.call
        city.reload
        total = 0
        city.reviews.each do |review|
          total += review.total_rating * review.weight
        end
        total_weighted_average = total / city.reviews.size
        expect(city.rating).to eq(total_weighted_average.round(2)) # (7.2 + 4.8) / 2 = 6.0
        expect(city.calculated).to be true
      end
    end

    context "when city has no reviews" do
      it "update calculated to true" do
        expect(city.rating).to eq(0)
        expect(city.reviews.size).to eq(0)
        result = service.call
        city.reload
        expect(city.rating).to eq(0)
        expect(city.calculated).to be true
      end
    end

    context "when an exception occurs during calculation" do
      before do
        create(:review, total_rating: 8.0, weight: 0.9, cities: [city])
        allow(city).to receive(:update).and_raise(StandardError, "Database error")
      end

      it "adds an error and does not update the city" do
        result = service.call
        expect(service.errors.first).to match(/Failed to calculate city rating: Database error/)
        city.reload
        expect(city.rating).to eq(0 )
        expect(city.calculated).to be false
      end
    end
  end
end
