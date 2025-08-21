module Api
  module V1
    class ApiController < ActionController::API
      before_action :initialize_model
      before_action :initialize_object, only: %w[show update destroy]

      # GET /models
      def index
        @collection = @model.all

        render json: @collection
      end

      # GET /models/1
      def show
        render json: @object
      end

      # POST /models
      def create
        @object = @model.new(country_params)

        if @object.save
          render json: @object, status: :created, location: @object
        else
          render json: @object.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /model/1
      def update
        if @object.update(country_params)
          render json: @object
        else
          render json: @object.errors, status: :unprocessable_entity
        end
      end

      # DELETE /models/1
      def destroy
        @object.destroy!
      end

      private

        # Use callbacks to share common setup or constraints between actions.
        def initialize_model
          @model = self.class.model_name.safe_constantize
        end

        # Use callbacks to share common setup or constraints between actions.
        def initialize_object
          @object = @model.find(params.expect(:id))
        end

        # Only allow a list of trusted parameters through.
        def country_params
          params.fetch(:country, {})
        end
    end
  end
end

