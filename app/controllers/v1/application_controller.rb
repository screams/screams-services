module V1
  class ApplicationController < ::ApplicationController
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    def current_user
      ::User.find_by_encrytped_authentication_token(params[:authentication_token])
    end

  private
    def respond_with_CRUD_json_response(object, options = {})
      errors_present = object.errors.present?
      error_messages = object.errors.full_messages
      failure        = (errors_present or !object.valid?)
      resp = {
        :success                                    => failure ? 0 : 1,
        "#{object.class.name.underscore}"           => failure ? nil : object
      }
      options.symbolize_keys
      resp.merge!({ :redirect_uri => redirect_uri }) if options[:redirect_uri].present?
      resp.merge!({ :errors => error_messages }) if errors_present
      render :json => resp
    end
  end
end
