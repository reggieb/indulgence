require 'indulgence'

class ThingPermission < Indulgence::Permission
  
  def abilities
    {
      god: default.merge(god),
      demigod: default.merge(demigod),
      thief: default.merge(thief),
      friend: default.merge(friend)
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
      update: all,
      delete: all
    }
  end
  
  def demigod
    {
      create: things_they_own,
      update: things_they_own,
      delete: things_they_own
    }
  end
  
  def thief
    {
      update: things_they_stole
    }
  end
  
  def friend
    {
      update: things_they_borrow
    }
  end
  
  def things_they_own
    define_ability(
      name: :things_they_own,
      compare_single: lambda {|thing, user| thing.owner_id == user.id},
      filter_many: lambda {|things, user| things.where(:owner_id => user.id)}
    )
  end
  
  def things_they_stole
    define_ability(:owner_id)
  end
  
  def things_they_borrow
    define_ability(:owner)
  end
  
end
