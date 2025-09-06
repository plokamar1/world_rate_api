module Api
  module V1
    class UsersController < ApiController
      protected

        def self.model_name
          "User"
        end
    end
  end
end
