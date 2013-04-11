module Indulgence
  module Indulgent
    
    module ClassMethods      
      def indulgence(entity, ability)
        permission = indulgent_permission_class.new(entity, ability)
        where(permission.filter_many)
      rescue Indulgence::NotFoundError
        raise_not_found
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
