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
    @things_they_own ||= define_ability(
      :name => :things_they_own,
      :truth => lambda {|thing| thing.owner_id == entity.id},
      :where_clause => {:owner_id => entity.id}
    )
  end
  
end
