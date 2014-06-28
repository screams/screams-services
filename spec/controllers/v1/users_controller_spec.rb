require 'spec_helper'
require 'request_helper'

describe V1::UsersController, :type => :controller do
  describe "POST 'create'" do
    before(:all){
      clean!
    }

    context "when there are no validation erorrs" do
      it "should create the user and return the JSON of the user object" do
        to_create_email = "this@email.com"
        post "create", :user => {
          :email => to_create_email
        }
        expect(response).to be_success
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["user"]["email"]).to be_eql(to_create_email)
        expect(parsed_response["user"]["id"]).to_not be_nil
        expect(parsed_response).to be_a_success_response
        expect(User.where(:email => to_create_email)).to have(1).record
      end
    end

    context 'when there are validation errors' do
      context "when the email is not unique" do
        let(:user) { FactoryGirl.create(:user) }

        it "should return failure response with error message in email" do
          post "create", :user => {
            :email => user.email
          }
          expect(response).to be_success
          parsed_response = JSON.parse(response.body)
          expect(parsed_response).to be_a_failure_response
          expect(parsed_response).to have_empty("user")
          expect(parsed_response).to have_errors
          expect(User.where(:email => user.email)).to have(1).record
        end
      end
    end
  end
end