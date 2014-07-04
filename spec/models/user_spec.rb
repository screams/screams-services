require 'spec_helper'
require 'request_helper'

describe User do
  before(:all){
    clean!
  }

  describe "Validations" do

    context "email" do
      subject { User.new }

      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should_not allow_value('abc123!@#$%%^^&&').for(:email) }
      it { should_not allow_value('sdfasdjh2121').for(:email) }
      it { should_not allow_value('*12email@test.com').for(:email) }
      it { should_not allow_value('12!email@test.com').for(:email) }
      it { should_not allow_value('12@email@test.com').for(:email) }
      it { should_not allow_value('^12email@test.com').for(:email) }
      it { should_not allow_value('12email@....com').for(:email) }
      it { should_not allow_value('.any@domai.com').for(:email) }
      it { should_not allow_value('$any@domai.com').for(:email) }
      it { should allow_value('12email+1@doma.com').for(:email) }
      it { should allow_value('90any@domai.com').for(:email) }
      it { should allow_value('12email@sub.domain.in').for(:email) }
      it { should allow_value('t.someone@sub.domain.in').for(:email) }
      it { should allow_value('t-someone@sub.domain.in').for(:email) }
      it { should allow_value('t_someone@sub.domain.in').for(:email) }
      it { should allow_value('t-someV12one@sub.domain.in').for(:email) }
    end
  end

  describe "Assosciations" do
    subject { FactoryGirl.build(:user) }

    it { should have_many(:screams) }
    it { should have_many(:authentication_tokens) }
  end

  describe "#generate_authentication_token" do
    context "when there is an existing authentication token with the same hash" do
      let(:auth_token) {
        FactoryGirl.create(:authentication_token)
      }   
      let(:user){
        FactoryGirl.create(:user)
      }
         
      before(:each) do
        OpenSSL::HMAC.any_instance.stub(:hexdigest) do
          OpenSSL::HMAC.unstub(:hexdigest)
          auth_token.token
        end   
      end
      
      it "should generate a authentication_token with a new hash and return encrypted auth token" do
        enc = user.generate_authentication_token
        expect(user.reload.authentication_tokens).to have(1).record
        expect(Devise.token_generator.digest(AuthenticationToken, :token, enc))
          .to be_eql(user.reload.authentication_tokens.first.token)
      end
    end

    context "when there are not authentication tokens with the hash that is generated" do
      let(:user){
        FactoryGirl.create(:user)
      }

      it "should generate a authentication_token and return encrypted auth token" do
        enc = user.generate_authentication_token
        expect(user.reload.authentication_tokens).to have(1).record
        expect(Devise.token_generator.digest(AuthenticationToken, :token, enc))
          .to be_eql(user.reload.authentication_tokens.first.token)
      end
    end
  end
  
  describe ".find_by_encrytped_authentication_token" do  
    context "when a user with authentication token is present" do
      let(:user){
        FactoryGirl.create(:user)
      }
      before(:each){
        @enc = user.generate_authentication_token
      }

      it 'should return user' do
        user_from_find = User.find_by_encrytped_authentication_token(@enc)
        user_from_find.should be_eql(user)
      end
    end

    context "when a authentication_token is not present with the given token" do
      it "should return nil" do
        User.find_by_encrytped_authentication_token('MyMercy').should be_nil
      end
    end
  end
end