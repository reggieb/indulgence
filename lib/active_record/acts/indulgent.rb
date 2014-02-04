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
          
          alias_method args[:compare_single_method], :indulge? if args[:compare_single_method]
          singleton_class.send(:alias_method, args[:filter_many_method], :indulgence) if args[:filter_many_method]
          singleton_class.send(:alias_method, args[:compare_single_method], :indulge?) if args[:compare_single_method]
          self.indulgent_permission_class = args[:using]
        end
        
        def indulgent_permission_class
          @indulgent_permission_class
        end
        
        private
        def default_indulgence_permission_class
          class_name = to_s
          name = class_name + "Permission"
          require name.underscore
          if const_defined? name
            class_eval name
          end
        end

        def indulgent_permission_class=(klass = nil)
          @indulgent_permission_class = klass || default_indulgence_permission_class
        end
        
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::Indulgent)