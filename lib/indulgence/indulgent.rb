module Indulgence
  module Indulgent
    
    module ClassMethods
      
    end
    
    module InstanceMethods
      
      def indulge?(entity, ability)
        permission = ThingPermission.new(entity)
        return !!permission[ability.to_sym]
      end
      
    end
      
  end
end
