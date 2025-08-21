# frozen_string_literal: true

require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe Api::V1::CountriesController, type: :controller do
  # before do
  #   # Do nothing
  # end
  #
  # after do
  #   # Do nothing
  # end

  let(:country) { create(:country) }
  let(:user) { create(:user, :with_reviews, review_country: country) }
  let(:valid_attributes) { attributes_for(:country) }

  describe "GET #index" do
    before do
      get :index
    end

    it { should use_before_action(:initialize_model) }
    it { should respond_with(:success) }
  end

  describe "GET #show" do
    before do
      get :show, params: { id: country.id }
    end

    it { should use_before_action(:initialize_model) }
    it { should use_before_action(:initialize_object) }
    it { should respond_with(:success) }
  end

  describe "closed routes" do
    it "raises ActionController::UrlGenerationError for CREATE action" do
      expect { post :create, params: valid_attributes }.to raise_error(ActionController::UrlGenerationError)
    end
    it "raises ActionController::UrlGenerationError for UPDATE action" do
      expect { post :update, params: { id: country.id, name: "TestName" } }.to raise_error(ActionController::UrlGenerationError)
    end
    it "raises ActionController::UrlGenerationError for DESTROY action" do
      expect { delete :destroy, params: { id: country.id} }.to raise_error(ActionController::UrlGenerationError)
    end
  end

end
