
module Indulgence
  class Ability
    attr_reader :name, :compare_single, :filter_many
    
    def initialize(args = {})
      @name = args[:name]
      @compare_single = args[:compare_single]
      @filter_many = args[:filter_many]
      valid?
    end
    
    def ==(another_ability)
      [:name, :compare_single, :filter_many].each do |method|
        return false if send(method) != another_ability.send(method)
      end
      return true
    end
    
    def valid?
      must_be_name
      must_respond_to_call :compare_single
      must_respond_to_call :filter_many
    end
    
    private
    def must_be_name
      unless name
        raise AbilityConfigurationError, "A name is required for each ability"
      end
    end
    
    def must_respond_to_call(method)
      unless send(method).respond_to? :call
        raise AbilityConfigurationError, "ability.#{method} must respond to call"
      end
    end
    
    
  end
end
