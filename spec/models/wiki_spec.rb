require 'spec_helper'

describe Wiki do

  context 'associations' do
    it "should have many wiki versions" do
      should have_many :versions
    end
  end

  context "after_create hook for versions" do
    it "should create the first version after create" do
      Factory(:wiki)
      WikiVersion.count.should == 1
    end
  end
end
