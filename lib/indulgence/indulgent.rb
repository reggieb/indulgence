module Indulgence
  module Indulgent
    
    module ClassMethods      
      def indulgence(entity, ability)
        permission = indulgent_permission_class.new(entity, ability)
        permission.filter_many(self)
      rescue Indulgence::NotFoundError, Indulgence::AbilityNotFound
        raise_not_found
      end

      def indulge?(entity, ability)
        new.indulge?(entity, ability)
      end
      
      private
      def raise_not_found
        raise ActiveRecord::RecordNotFound.new('Unable to find the item(s) you were looking for')
      end
    end
    
    module InstanceMethods
      
      def indulge?(entity, ability)
        permission = self.class.indulgent_permission_class.new(entity, ability)
        return permission.compare_single self
      end
      
    end
      
  end
end
