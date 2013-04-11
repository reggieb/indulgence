require 'indulgence'
require 'role'
require 'user'
require 'thing_permission'
class Thing < ActiveRecord::Base

  belongs_to :owner, :class_name => 'User'
  
  acts_as_indulgent(
    :truth_method => :permit?,
    :where_method => :permitted
  )
  
end

class OtherThing < Thing
  
  acts_as_indulgent :using => ThingPermission
  
end


