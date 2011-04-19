require 'spec_helper'

describe WikiVersion do

  context "associations" do
    it "should belong to user and wiki" do
      should belong_to :user
      should belong_to :wiki
    end
  end

  context "state machine" do
    it "should initially be in active state" do
      wiki_version = Factory(:wiki_version)
      wiki_version.should be_active
    end

    it "should change state if archived" do
      wiki_version = Factory(:wiki_version)
      wiki_version.archive!
      wiki_version.should be_archived
    end
  end



end