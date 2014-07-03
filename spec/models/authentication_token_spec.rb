require 'rails_helper'

describe AuthenticationToken do
  before(:all){
    clean!
  }

  describe "Assosciations" do
    subject { FactoryGirl.build(:authentication_token) }

    it { should belong_to(:user) }
  end
end
