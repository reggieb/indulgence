

module Indulgence
  module AbilityTests
    class WithLambdas < Test::Unit::TestCase

      def setup
        @attributes = {
          name: :foo, 
          compare_single: lambda {|thing, entity| true},
          filter_many: lambda {|entity| nil}
        }
      end

      def test_equality
        ability = Ability.new(@attributes)
        other_ability = Ability.new(@attributes)
        assert(ability == other_ability, "#{ability} == #{other_ability} should return true")
        assert_equal(ability, other_ability)
      end

      def test_name_absence_raises_error
        @attributes.delete(:name)
        assert_initiation_raises_error
      end

      def test_indulge_must_respond_to_call
        @attributes[:compare_single] = true
        assert_initiation_raises_error
      end

      def test_indulgence_must_respond_to_call
        @attributes[:filter_many] = true
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
