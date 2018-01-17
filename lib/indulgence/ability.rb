
module Indulgence
  class Ability
    attr_reader :name, :relationship, :args

    def initialize(args = {})
      @name = args[:name]
      @compare_single = args[:compare_single]
      @filter_many = args[:filter_many]
      @relationship = args[:relationship]
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
      unless relationship
        must_respond_to_call @compare_single
        must_respond_to_call @filter_many
      end
    end

    def compare_single(thing, entity)
      return @compare_single.call thing, entity if @compare_single

      identifier = thing.send(relationship)
      if identifier.kind_of?(Array) || identifier.kind_of?(ActiveRecord::Relation)
        identifier.include? entity
      else
        identifier == entity.id || identifier == entity
      end
    end

    def filter_many(things, entity)
      return @filter_many.call things, entity if @filter_many

      if things.reflect_on_association(relationship)
        things.joins(relationship).where(entity.class.table_name => {:id => entity.id})
      else
        things.where(relationship => entity.id)
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
