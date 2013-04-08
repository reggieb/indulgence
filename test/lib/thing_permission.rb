require 'indulgence'

class ThingPermission < Indulgence::Permission
  
  def abilities
    {
      god: default.merge(god),
      demigod: default.merge(demigod)
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
  
  def demigod
    {
      create: things_they_own,
      read: all,
      update: things_they_own,
      delete: things_they_own
    }
  end
  
  def things_they_own
    
  end
  
end
