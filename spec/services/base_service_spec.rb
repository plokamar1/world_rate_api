# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseService do
  let(:service) { described_class.new }

  describe "#call" do
    it "raises NoMethodError when called directly" do
      expect { service.call }.to raise_error(NoMethodError)
    end
  end

  describe "#success" do
    it "without any errors" do
      expect(service.errors).to eq([]) # or .size to eq(0)
      expect(service.success?).to be true
    end

    it "with errors" do
      service.send(:add_error, "Another error")
      expect(service.errors.size).to eq(1)
      expect(service.success?).to be false
    end
  end

  describe "#failure" do
    it "without any errors" do
      expect(service.errors).to eq([]) # or .size to eq(0)
      expect(service.failure?).to be false
    end

    it "with errors" do
      service.send(:add_error, "Another error")
      expect(service.errors.size).to eq(1)
      expect(service.failure?).to be true
    end
  end

  describe "#add_error" do
    it "adds an error using add_error" do
      expect(service.errors).to eq([])
      service.send(:add_error, "Test error")
      expect(service.errors).to include("Test error")
    end

    it "returns empty array when no errors added" do
      expect(service.errors).to eq([]) # or .size to eq(0)
    end
  end
end
