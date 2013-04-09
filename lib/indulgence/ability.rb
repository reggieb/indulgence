
module Indulgence
  class Ability
    attr_reader :name, :truth, :where_clause
    
    def initialize(args = {})
      @name = args[:name]
      @truth = args[:truth]
      @where_clause = args[:where_clause]
    end
    
    def ==(another_ability)
      [:name, :truth, :where_clause].each do |method|
        return false if send(method) != another_ability.send(method)
      end
      return true
    end
  end
end
