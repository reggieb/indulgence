require_relative '../../test_helper'
require 'user'

module Indulgence
  class PermissionTest < Test::Unit::TestCase
    
    def test_creation_fails_as_methods_undefined_in_parent_class
      assert_raise RuntimeError do
        Permission.new(User.create(:name => 'Whisp'), :read)
      end
    end
    

  end
end
