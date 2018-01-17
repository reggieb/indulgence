require_relative '../test_helper'
require 'user'
require 'role'
require 'role_permission'

class RolePermissionTest < Minitest::Test
  def setup
    @role = Role.create(:name => 'mortal')
    @user = User.create(:name => 'Trevor', :role_id => @role.id)
  end

  def test_indulge_with_has_many
    @role.reload
    assert_equal(true, @role.indulge?(@user, :read))
    assert_equal(false, @role.indulge?(@user, :delete))
  end

  def test_indulgence_with_has_many
    assert_equal([@role], Role.indulgence(@user, :read))
    assert_raises ActiveRecord::RecordNotFound do
      Role.indulgence(@user, :delete)
    end
  end

  def test_null_entity_indulge
    assert_equal(false, @role.indulge?(nil, :update))
    refute_equal(@role.indulge?(@user, :update), @role.indulge?(nil, :update))
  end

  def test_null_entity_indulgence
    assert_raises ActiveRecord::RecordNotFound do
      assert_equal(0, Role.indulgence(nil, :update).count)
    end
  end

  def teardown
    User.delete_all
    Role.delete_all
  end
end
