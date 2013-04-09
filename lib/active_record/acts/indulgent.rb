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
          
          @indulgent_permission_class = args[:using] || default_indulgence_permission_class
          
          alias_method args[:truth_method], :indulge? if args[:truth_method]
          singleton_class.send(:alias_method, args[:where_method], :indulgence) if args[:where_method]
        end
        
        private
        def default_indulgence_permission_class
          class_name = to_s
          name = class_name + "Permission"
          if const_defined? name
            class_eval name
          end
        end
        
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::Indulgent)