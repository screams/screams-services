require 'spec_helper'
require 'request_helper'

describe Scream do
  before(:all){
    clean!
  }

  describe "Assosciations" do
    subject { FactoryGirl.build(:scream) }

    it { should belong_to(:user) }
  end
end