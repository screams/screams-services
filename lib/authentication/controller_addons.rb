module Authentication

  # This module is automatically included into all controllers.
  # It also makes the "can?" and "cannot?" methods available to all views.
  module ControllerAddons
    module ClassMethods
      # Sets up a before filter which loads and authorizes the current resource. This performs both
      # load_resource and authorize_resource and accepts the same arguments. See those methods for details.
      #
      #   class BooksController < ApplicationController
      #     load_and_authorize_resource
      #   end
      #
      def load_and_authorize_resource(*args)
        cancan_resource_class.add_before_filter(self, :load_and_authorize_resource, *args)
      end
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Authentication::ControllerAddons
  end
end