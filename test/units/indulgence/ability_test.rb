require_relative '../../test_helper'
require 'ability'

module Indulgence
  class AbilityTest < Test::Unit::TestCase
    
    def test_none
      none = Ability.new(
        :name => :none,
        :indulge => false
      )
      assert_equal(:none, none.name)
      assert_equal(false, none.indulge)
      assert_equal(nil, none.indulgence)
    end
    
    def test_all
      all = Ability.new(
        :name => :all,
        :indulge => true
      )
      assert_equal(:all, all.name)
      assert_equal(true, all.indulge)
      assert_equal(nil, all.indulgence)
    end
    
    def test_equality
      attributes = {:name => :same, :true => true}
      ability = Ability.new(attributes)
      other_ability = Ability.new(attributes)
      assert(ability == other_ability, "#{ability} == #{other_ability} should return true")
      assert_equal(ability, other_ability)
    end
    
  end
end
