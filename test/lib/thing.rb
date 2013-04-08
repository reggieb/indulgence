
class Thing < ActiveRecord::Base

  belongs_to :owner, :class_name => 'User'
  
  acts_as_indulgent
  
end

class OtherThing < Thing
  
  acts_as_indulgent :using => ThingPermission
  
end
