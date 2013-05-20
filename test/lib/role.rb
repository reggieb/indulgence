require 'indulgence'

class Role < ActiveRecord::Base
  has_many :users
  
  acts_as_indulgent
  
  def title
    self.name
  end
end
