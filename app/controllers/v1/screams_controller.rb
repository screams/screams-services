module V1
  class ScreamsController < V1::ApplicationController
    
    # before_filter :authenticate_user

    def create
      scream = Scream.create(scream_params)
      respond_with_CRUD_json_response(scream)
    end

  private 

    def scream_params
      params.require(:scream).permit([
        :text, :private_scream, :user_id
      ])
    end

  end
end