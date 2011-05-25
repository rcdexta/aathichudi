require 'spec_helper'

describe TextileController do

  it "should resolve routes" do
    should route(:get, '/textile_preview').to(:controller => 'textile', :action => 'preview')
  end

  describe "#preview" do
    it "should convert textile to html" do
      get :preview, :text => '*Textile*'
      assigns[:html].should === "<p><strong>Textile</strong></p>"
    end
  end

end
