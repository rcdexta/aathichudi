class WikiVersion < ActiveRecord::Base

  belongs_to :user
  belongs_to :wiki

  state_machine :state, :initial => :active do
    event :archive do
      transition :active => :archived
    end
  end

end