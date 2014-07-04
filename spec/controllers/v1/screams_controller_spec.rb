require 'spec_helper'
require 'request_helper'

describe V1::ScreamsController, :type => :controller do
  before(:all){
    clean!
  }  

  describe "POST 'create'" do
    context "when the required data is sent in parameters" do
      let(:user) {
        FactoryGirl.create(:user)
      }
      let(:request_params){
        {
          :text => "This is a sample text for each scream",
        }
      }

      it "should create the scream and return with the record" do
        token = user.generate_authentication_token
        post "create", :scream => request_params, :authentication_token => token
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to be_a_success_response
        expect(parsed_response).to_not have_errors
        expect(parsed_response["scream"]).to be_a_json_of(user.reload.screams.first)
        expect(user.reload.screams).to have(1).record
      end

      context "when the authentication_token is not passed" do
        it "should return 401 Status" do
          post "create", :scream => request_params
          response.status.should be_eql(401)
        end
      end
    end
  end
end