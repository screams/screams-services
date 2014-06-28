module V1
  class UsersController < V1::ApplicationController
    def create
      user = User.create(user_params)
      respond_with_CRUD_json_response(user)
    end

  private 

    def user_params
      params.require(:user).permit([
        :email
      ])
    end
  end
end