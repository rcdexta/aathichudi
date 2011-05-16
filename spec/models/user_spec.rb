require 'spec_helper'

describe User do

  context "create hooks" do
    it "should call bootstrap user before create" do
      User.any_instance.expects(:bootstrap_user)
      Factory(:user)
    end

    it "should send welcome mail after create" do
      User.any_instance.expects(:send_welcome_email)
      Factory(:user)
    end
  end

end