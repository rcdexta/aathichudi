class Wiki < ActiveRecord::Base

  # acts_as_versioned

  state_machine :state, :initial => :draft do
    event :approve do
      transition :draft => :active
    end
  end

  def latest_active
    self
    # self.versions.select { |wiki| wiki.state == 'active' }.last.wiki
  end
end
