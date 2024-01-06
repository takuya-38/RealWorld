module Api
  class UsersController < ApplicationController
    include JwtAuthenticator
    before_action :jwt_authenticate, except: :create

    def create
      user = User.new(user_params)
      if user.save
        render json: { user: user }, status: :created
      else
        render json: { errors: user.errors }, status: :unprocessable_entity
      end
    end

    private
      def user_params
        params.require(:user).permit(:username, :email, :password)
      end
  end
end
