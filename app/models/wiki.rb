class Wiki < ActiveRecord::Base

  has_many :versions, :class_name => "WikiVersion"

end
