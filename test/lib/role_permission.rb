require 'indulgence'

class RolePermission < Indulgence::Permission
  def default
    {
      create: from_has_many,
      read: from_has_many,
      update: all,
      delete: none
    }
  end
  
  def from_has_many
    define_ability(:users)
  end
end
