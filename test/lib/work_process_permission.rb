require 'indulgence'

class WorkProcessPermission < Indulgence::Permission
  
  def abilities
    {
      beginning: beginning,
      middle: middle,
      finish: finish
    }
  end
  
  def beginning
    {
      create: all,
      read: all,
      update: none,
      delete: all
    }
  end
  
  def middle
    {
      create: none,
      read: all,
      update: all,
      delete: all
    }
  end
  
  def finish
    {
      create: none,
      read: all,
      update: none,
      delete: none
    }
  end
  
end
