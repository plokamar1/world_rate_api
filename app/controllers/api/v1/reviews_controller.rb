module Api
  module V1
    class ReviewsController < ApiController
      protected

        def self.model_name
          "Review"
        end
    end
  end
end
