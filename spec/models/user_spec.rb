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
end