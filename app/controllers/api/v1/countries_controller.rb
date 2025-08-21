module Api
  module V1
    class CountriesController < ApiController

      protected

        def self.model_name
          "Country"
        end
    end
  end
end
