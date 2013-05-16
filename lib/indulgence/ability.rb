
module Indulgence
  class Ability
    attr_reader :name, :entity_id_method, :args
    
    def initialize(args = {})
      @name = args[:name]
      @compare_single = args[:compare_single]
      @filter_many = args[:filter_many]
      @entity_id_method = args[:entity_id_method]
      @args = args
      valid?
    end
    
    def ==(another_ability)
      [:name, :args].each do |method|
        return false if send(method) != another_ability.send(method)
      end
      return true
    end
    
    def valid?
      must_be_name
      unless entity_id_method
        must_respond_to_call @compare_single
        must_respond_to_call @filter_many
      end
    end
    
    def compare_single(thing, entity)
      if entity_id_method
        thing.send(entity_id_method) == entity.id
      else
        @compare_single.call thing, entity   
      end
    end
    
    def filter_many(things, entity)
      if entity_id_method
        things.where(entity_id_method => entity.id)
      else
        @filter_many.call things, entity   
      end
    end
    
    private
    def must_be_name
      unless name
        raise AbilityConfigurationError, "A name is required for each ability"
      end
    end
    
    def must_respond_to_call(item)
      unless item.respond_to? :call
        raise AbilityConfigurationError, "item must respond to call: #{item.inspect}"
      end
    end
    
    
  end
end
