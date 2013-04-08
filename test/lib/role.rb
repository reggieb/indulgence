class Role < ActiveRecord::Base
  has_many :users
  
  def title
    self.name
  end
end
