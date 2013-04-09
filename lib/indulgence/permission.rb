module Indulgence
  class Permission
    attr_reader :entity, :ability

    def initialize(entity, ability)
      self
      @entity = entity
      @ability = abilities_for_role[ability]
    end

    def abilities
      raise "abilities needs to be defined"
    end
    
    def default
      raise 'There must always be a default'
    end
    
    def where
      ability.where_clause
    end
    
    def indulge?(thing)
      ability.truth.respond_to?(:call) ? ability.truth.call(thing) : ability.truth
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
      define_ability(
        :name => :none,
        :truth => false
      )
    end

    def self.all
      define_ability(
        :name => :all,
        :truth => true
      )
    end
    
    def self.define_ability(args)
      Ability.new args
    end
    
    def define_ability(args)
      self.class.define_ability(args)
    end

    # Ensure passing an unknown key behaves as one would expect for a hash 
    def [](key)
      return {}[key] unless keys.include? key
      super
    end
    
    def role_name
      @role_name ||= entity_role_name
    end
    
    def abilities_for_role
      abilities[role_name] || default
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
