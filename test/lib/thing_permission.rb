require 'indulgence'

class ThingPermission < Indulgence::Permission

    
  def abilities
    {
      default: default,
      god: default.merge(god),

    }
  end
  
  
  def default
    {
      create: none,
      read: all,
      update: none,
      delete: none
    }
  end
  
  def god
    {
      create: all,
      read: all,
      update: all,
      delete: all
    }
  end
  
end
