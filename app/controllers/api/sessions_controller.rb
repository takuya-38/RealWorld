module Api
  class SessionsController < ApplicationController
    include JwtAuthenticator

    def create
      user = User.find_by(email: session_params[:email])

      if user&.authenticate(session_params[:password])
        user.token = encode(user.id)
        response.headers['X-Authentication-Token'] = user.token
        render json: { user: user }
      else
        render json: { errors: { 'user' => ['not found or invalid credentials'] } }, status: :unprocessable_entity
      end
    end

    private
      def session_params
        params.require(:user).permit(:email, :password)
      end
  end
end
