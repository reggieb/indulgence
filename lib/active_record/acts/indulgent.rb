module ActiveRecord
  module Acts
    module Indulgent
      def self.included(base)
        base.send :extend, ClassMethods
      end
      
      module ClassMethods
        def acts_as_indulgent
          include Indulgence::Indulgent::InstanceMethods
          extend Indulgence::Indulgent::ClassMethods
        end
        
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::Indulgent)