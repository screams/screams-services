module V1
  class ApplicationController < ::ApplicationController
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    # Apply strong_parameters filtering before CanCan authorization
    # See https://github.com/ryanb/cancan/issues/571#issuecomment-10753675
    before_filter do
      resource = controller_name.singularize.to_sym
      method = "#{resource}_params"
      params[resource] &&= send(method) if respond_to?(method, true)
    end

    def current_user
      ::User.find_by_encrytped_authentication_token(params[:authentication_token])
    end

    rescue_from ::CanCan::AccessDenied do
      head :unauthorized
    end
  end
end
