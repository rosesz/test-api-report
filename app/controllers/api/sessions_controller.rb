module Api
  class SessionsController < ApiController
    def create
      resource = User.find_for_database_authentication(:username => params[:username])
      return invalid_login_attempt unless resource

      if resource.valid_password?(params[:password])
        auth_token = resource.generate_auth_token
        render json: { auth_token: auth_token }
      else
        invalid_login_attempt
      end
    end

    def destroy
      resource = current_person
      resource.invalidate_auth_token
      head :ok
    end

    private

    def invalid_login_attempt
      render json: { errors: [ { detail: "Error with your login or password" }]}, status: 401
    end
  end
end