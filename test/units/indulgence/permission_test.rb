require_relative '../../test_helper'
require 'user'
require 'indulgence'
require 'permission'
require 'ability'

module Indulgence
  class PermissionTest < Minitest::Test
    
    def test_creation
      permission = Permission.new(User.create(:name => 'Whisp'), :read)
      assert_equal Permission.none, permission.default[:read]
    end
    
    def test_define_ability_uses_cache_rather_than_duplicates
      args = {
        name: :test_ability,
        compare_single: lambda {|thing, entity| true},
        filter_many: lambda {|entity| nil}
      }
      abilities_at_start = ObjectSpace.each_object(Ability).count
      Permission.define_ability args
      Permission.define_ability args
      Permission.define_ability args
      assert_equal((abilities_at_start + 1), ObjectSpace.each_object(Ability).count)
      assert_equal Ability, Permission.send(:ability_cache)[:test_ability].class
    end

    def test_creation_with_null_entity
      permission = Permission.new(nil, :read)
      assert_equal Permission.none, permission.ability
    end

    def test_creation_with_entity_that_does_not_respond_to_role
      before = Indulgence.strict?
      Indulgence.strict = false
      permission = Permission.new([], :read)
      assert_equal Permission.none, permission.ability
      Indulgence.strict = before
    end

  end
end
