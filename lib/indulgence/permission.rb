module Indulgence
  class Permission
    attr_reader :entity, :ability

    def initialize(entity, ability)
      self
      @entity = entity
      @ability = abilities_for_role[ability]
      raise AbilityNotFound, "Unable to find an ability called #{ability}" unless @ability
    end

    def abilities
      {}
    end
    
    def default
      raise 'There must always be a default'
    end
    
    def filter_many(things)
      ability.filter_many things, entity
    end
    
    def compare_single(thing)
      ability.compare_single thing, entity
    end
    
    @@role_method = :role
    
    def self.role_method=(name)
      @@role_method = name.to_sym
    end

    def self.role_method
      @@role_method
    end
    
    @@role_name_method = :name
    
    def self.role_name_method=(name)
      @@role_name_method = name.to_sym
    end

    def self.role_name_method
      @@role_name_method
    end

    def self.none
      Permission.define_ability(
        :name => :none,
        :compare_single => lambda {|thing, entity| false},
        :filter_many => lambda {|things, entity| raise NotFoundError}
      )
    end

    def self.all
      Permission.define_ability(
        :name => :all,
        :compare_single => lambda {|thing, entity| true},
        :filter_many => lambda {|things, entity| things.where(nil)}
      )
    end
    
    def self.define_ability(args)
      raise AbilityConfigurationError, "A name is required for each ability" unless args[:name]
      ability_cache[args[:name].to_sym] ||= Ability.new args
    end
    
    def define_ability(args)
      self.class.define_ability(args)
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
    
    def self.ability_cache
      @ability_cache ||= {}
    end
    
  end
end
