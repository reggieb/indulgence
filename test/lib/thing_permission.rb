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
  
  def things_they_own
    define_ability(
      :name => :things_they_own,
      :compare_single => lambda {|thing, user| thing.owner_id == user.id},
      :filter_many => lambda {|things, user| things.where(:owner_id => user.id)}
    )
  end
  
end
