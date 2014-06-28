require 'spec_helper'
require 'request_helper'

describe V1::User::RegistrationsController, :type => :controller do
  before(:all){
    clean!
  }

  before(:each){
    request.env["devise.mapping"] = Devise.mappings[:user]  
  }

  describe "POST 'create'" do
    context "when there are no validation errors" do
      it "should return the success response and user hash along with authentication_token" do
        to_create_email = 'this@gmail.com'
        post 'create', :user => {
          :email => to_create_email,
          :password => "password123"
        }
        expect(response).to be_success
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to be_a_success_response
        expect(parsed_response).to_not have_errors
        expect(parsed_response["user"]["email"]).to be_eql(to_create_email)
        expect(parsed_response["user"]["authentication_token"]).to_not be_nil
        expect(User.where(:email => to_create_email)).to have(1).record
      end
    end

    context "when there are validation errors" do
      context "when the email is already in use" do
        let(:user) { FactoryGirl.create(:user) }

        it "should return failure response with error message in email" do
          post "create", :user => {
            :email => user.email,
            :password => 'password123'
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