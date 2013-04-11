module Indulgence
  class Permission
    attr_reader :entity, :ability

    def initialize(entity, ability)
      self
      @entity = entity
      @ability = abilities_for_role[ability]
    end

    def abilities
      {}
    end
    
    def default
      raise 'There must always be a default'
    end
    
    def indulgence
      call_or_return ability.indulgence, entity
    end
    
    def indulge?(thing)
      call_or_return ability.indulge, thing, entity
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
        :indulge => lambda {|thing, user| false}
      )
    end

    def self.all
      Permission.define_ability(
        :name => :all,
        :indulge => lambda {|thing, user| true}
      )
    end
    
    def self.define_ability(args)
      raise "A name required for each ability" unless args[:name]
      ability_cache[args[:name].to_sym] ||= Ability.new args
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
    
    def self.ability_cache
      @ability_cache ||= {}
    end
    
    def call_or_return(item, *pass_to_process)
      item.respond_to?(:call) ? item.call(*pass_to_process) : item
    end
  end
end
