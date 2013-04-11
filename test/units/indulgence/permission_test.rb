require_relative '../../test_helper'
require 'user'
require 'permission'
require 'ability'

module Indulgence
  class PermissionTest < Test::Unit::TestCase
    
    def test_creation_fails_as_methods_undefined_in_parent_class
      assert_raise RuntimeError do
        Permission.new(User.create(:name => 'Whisp'), :read)
      end
    end
    
    def test_define_ability_uses_cache_rather_than_duplicates
      args = {:name => :test_ability, :indulge => true}
      abilities_at_start = ObjectSpace.each_object(Ability).count
      Permission.define_ability args
      Permission.define_ability args
      Permission.define_ability args
      assert_equal((abilities_at_start + 1), ObjectSpace.each_object(Ability).count)
      assert_equal Ability, Permission.send(:ability_cache)[:test_ability].class
    end

  end
end
