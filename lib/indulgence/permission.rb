# To change this template, choose Tools | Templates
# and open the template in the editor.

module Indulgence
  class Permission < Hash
  attr_accessor :user
  
  def initialize(user)
    self
    @user = user
    replace abilities[user_role_name]
  end
  
  def abilities
    raise "needs to be defined"
  end
  
  def self.none
    :none
  end
  
  def self.all
    :all
  end
  
  # Ensure passing an unknown key behaves as one would expect for a hash 
  def [](key)
    return {}[key] unless keys.include? key
    super
  end
  
  private
  def user_role_name
    role = user.role
    if role and abilities.keys.include?(role.name.to_sym)
      role.name.to_sym 
    else
      :default
    end
  end
  
  def all
    self.class.all
  end
  
  def none
    self.class.none
  end 
  end
end
