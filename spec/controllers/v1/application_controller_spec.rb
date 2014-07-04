require 'spec_helper'
require 'request_helper'

describe V1::ApplicationController, :type => :controller do
  describe "#current_user" do
    context 'when the authentication_token is sent in params' do
      context "when a user with the token present" do
        let(:user){
          FactoryGirl.create(:user)
        }

        before(:each){
          token = user.generate_authentication_token
          @controller.stub(:params).and_return({ :authentication_token => token })
        }

        it "should return the user" do
          @controller.current_user.should be_eql(user)
        end
      end

      context "when a user with the token NOT present" do
        before(:each){
          @controller.stub(:params).and_return({ :authentication_token => '67' })
        }

        it "should return nil" do
          @controller.current_user.should be_nil
        end
      end
    end
  end
end