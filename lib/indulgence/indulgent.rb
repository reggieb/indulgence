module Indulgence
  module Indulgent
    
    module ClassMethods
      def indulgent_permission_class
        @indulgent_permission_class
      end
      
      def indulgence(entity, ability)
        permission = indulgent_permission_class.new(entity, ability)
        raise_not_found if permission.ability == Permission.none or permission.blank?
        where(permission.where)
      end
      
      private
      def raise_not_found
        raise ActiveRecord::RecordNotFound.new('Unable to find the item(s) you were looking for')
      end
    end
    
    module InstanceMethods
      
      def indulge?(entity, ability)
        permission = self.class.indulgent_permission_class.new(entity, ability)
        return permission.indulge? self
      end
      
    end
      
  end
end
