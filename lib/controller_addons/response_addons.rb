module ControllerAddons
  # This module is automatically included into all controllers.
  module ResponseAddons
    def respond_with_CRUD_json_response(object, options = {})
      errors_present = object.errors.present?
      error_messages = object.errors.full_messages
      failure        = (errors_present or !object.valid?)
      resp = {
        :success                                    => failure ? 0 : 1,
        "#{object.class.name.underscore}"           => failure ? nil : object.as_json(options[:json_options])
      }
      options.symbolize_keys
      resp.merge!({ :redirect_uri => options[:redirect_uri] }) if options[:redirect_uri].present?
      resp.merge!({ :errors => error_messages }) if errors_present
      render :json => resp
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include ::ControllerAddons::ResponseAddons
  end
end