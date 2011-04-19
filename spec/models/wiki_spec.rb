require 'spec_helper'

describe Wiki do

  context 'associations' do
    it "should have many wiki versions" do
      should have_many :versions
    end
  end
end
