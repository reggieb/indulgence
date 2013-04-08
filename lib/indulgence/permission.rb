module Indulgence
  class Permission < Hash
    attr_accessor :entity

    def initialize(entity)
      self
      @entity = entity
      replace abilities[role_name] || default
    end

    def abilities
      raise "Indulgence#abilities needs to be defined"
    end
    
    def default
      raise 'There must always be an Indulgence#default'
    end
    
    def self.role_method=(name)
      @role_method = name.to_sym
    end

    def self.role_method
      @role_method || :role
    end
    
    def self.role_name_method=(name)
      @role_name_method = name.to_sym
    end

    def self.role_name_method
      @role_name_method || :name
    end

    def self.none
      nil
    end

    def self.all
      true
    end

    # Ensure passing an unknown key behaves as one would expect for a hash 
    def [](key)
      return {}[key] unless keys.include? key
      super
    end
    
    def role_name
      @role_name ||= entity_role_name
    end

    private
    def entity_role_name
      role = entity.send(self.class.role_method)
      name_method = self.class.role_name_method
      if role and abilities.keys.include?(role.send(name_method).to_sym)
        role.send(name_method).to_sym
      else
        :default
      end
    end

    def all
      self.class.all
    end

    def none
      self.class.none
    end  
  end
end
