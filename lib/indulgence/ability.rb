
module Indulgence
  class Ability
    attr_reader :name, :indulge, :indulgence
    
    def initialize(args = {})
      @name = args[:name]
      @indulge = args[:indulge]
      @indulgence = args[:indulgence]
    end
    
    def ==(another_ability)
      [:name, :indulge, :indulgence].each do |method|
        return false if send(method) != another_ability.send(method)
      end
      return true
    end
  end
end
