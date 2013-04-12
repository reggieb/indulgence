require 'indulgence'
require 'role'
require 'user'
require 'thing_permission'
class Thing < ActiveRecord::Base

  belongs_to :owner, :class_name => 'User'
  
  acts_as_indulgent(
    :compare_single_method => :permit?,
    :filter_many_method => :permitted
  )
  
end

class OtherThing < Thing
  
  acts_as_indulgent :using => ThingPermission
  
end


