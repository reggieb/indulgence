
class Thing < ActiveRecord::Base

  belongs_to :owner, :class_name => 'User'
  
  acts_as_indulgent ThingPermission
  
end
