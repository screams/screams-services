class V1::User::RegistrationsController < Devise::RegistrationsController
  
  def create
    user = User.new(user_params)
    user.save
    respond_with_CRUD_json_response(user, :json_options => {
      :methods => [:authentication_token]
    })
  end

private
  
  def user_params
    params.require(:user).permit([
      :email, :password
    ])
  end

  def respond_with_CRUD_json_response(object, options = {})
    errors_present = object.errors.present?
    error_messages = object.errors.full_messages
    failure        = (errors_present or !object.valid?)
    resp = {
      :success                                    => failure ? 0 : 1,
      "#{object.class.name.underscore}"           => failure ? nil : object.as_json(options[:json_options])
    }
    options.symbolize_keys
    resp.merge!({ :redirect_uri => redirect_uri }) if options[:redirect_uri].present?
    resp.merge!({ :errors => error_messages }) if errors_present
    render :json => resp
  end
end
