
module Indulgence
  module AbilityTests
    class MethodOnly < Test::Unit::TestCase

      def setup
        @attributes = {
          name: :foo, 
          entity_id_method: :author
        }
      end

      def test_equality
        ability = Ability.new(@attributes)
        other_ability = Ability.new(@attributes)
        assert(ability == other_ability, "#{ability} == #{other_ability} should return true")
        assert_equal(ability, other_ability)
      end

      def test_name_absence_raises_error
        @attributes.delete :name
        assert_initiation_raises_error
      end

      def test_lack_of_entity_id_method
        @attributes.delete :entity_id_method
        assert_initiation_raises_error
      end
      
      def assert_initiation_raises_error
        assert_raise AbilityConfigurationError do
          Ability.new(@attributes)
        end
      end

    end
  end
end
