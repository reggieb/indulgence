module ActiveRecord
  module Acts
    module Indulgent
      def self.included(base)
        base.send :extend, ClassMethods
      end
      
      module ClassMethods
        def acts_as_indulgent(args = {})
          include Indulgence::Indulgent::InstanceMethods
          extend Indulgence::Indulgent::ClassMethods
          @indulgent_permission_class = args[:using] || auto_indulgence_permission_class
        end
        
        private
        def auto_indulgence_permission_class
          name = "#{to_s}Permission"
          if const_defined? name
            class_eval name
          end
        end
        
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::Indulgent)