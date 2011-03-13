require 'spec_helper'

describe Wiki do

  context "state_machine" do
    it "should change state to active on approve event" do
      wiki = Factory(:wiki)
      wiki.approve
      wiki.should be_active
    end
  end

  context "versions" do
    describe "#latest_active" do
      it "should fetch the latest active version" do
        wiki = Factory(:wiki)
        wiki.update_attribute(:paadal, 'new one')
        wiki.approve
        wiki.versions.count.should == 3
        wiki.latest_active.should be
        wiki.latest_active.paadal.should == 'new one'
      end
    end
  end
end
