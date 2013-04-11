
module Indulgence
  class Ability
    attr_reader :name, :indulge, :indulgence
    
    def initialize(args = {})
      @name = args[:name]
      @indulge = args[:indulge]
      @indulgence = args[:indulgence]
      valid?
    end
    
    def ==(another_ability)
      [:name, :indulge, :indulgence].each do |method|
        return false if send(method) != another_ability.send(method)
      end
      return true
    end
    
    def valid?
      must_be_name
      must_respond_to_call :indulge
      must_respond_to_call :indulgence
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
