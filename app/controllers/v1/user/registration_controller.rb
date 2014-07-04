class V1::User::RegistrationsController < Devise::RegistrationsController
  
  def create
    user = User.new(user_params)
    user.save
    respond_with_CRUD_json_response(user, :json_options => {
      :methods => [:encrypted_authentication_token]
    })
  end

private
  
  def user_params
    params.require(:user).permit([
      :email, :password
    ])
  end
end
