module V1
  class ScreamsController < V1::ApplicationController  
    load_and_authorize_resource

    def create
      scream = current_user.screams.create(scream_params)
      respond_with_CRUD_json_response(scream)
    end

  private 

    def scream_params
      params.require(:scream).permit([
        :text, :private_scream
      ])
    end

  end
end