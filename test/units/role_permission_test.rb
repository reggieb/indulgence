require_relative '../test_helper'
require 'user'
require 'role'
require 'role_permission'

class RolePermissionTest < Test::Unit::TestCase
  def setup
    @role = Role.create(:name => 'mortal')
    @user = User.create(:name => 'Trevor', :role_id => @role.id)
  end
  
  def test_indulge_with_has_many
    assert_equal(true, @role.indulge?(@user, :read))
    assert_equal(false, @role.indulge?(@user, :delete))
  end
  
  def test_indulgence_with_has_many
    assert_equal([@role], Role.indulgence(@user, :read))
    assert_raise ActiveRecord::RecordNotFound do
      Role.indulgence(@user, :delete)
    end
  end
  
  def teardown
    User.delete_all
    Role.delete_all
  end
end
