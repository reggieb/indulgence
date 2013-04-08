module Indulgence
  module Indulgent
    
    module ClassMethods
      def indulgent_permission_class
        @indulgent_permission_class
      end
    end
    
    module InstanceMethods
      
      def indulge?(entity, ability)
        permission = self.class.indulgent_permission_class.new(entity)
        return !!permission[ability.to_sym]
      end
      
    end
      
  end
end
