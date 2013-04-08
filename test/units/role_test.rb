require_relative '../test_helper'
require 'user'
require 'role'

class RoleTest < Test::Unit::TestCase
  def teardown
    User.delete_all
    Role.delete_all
  end
  
  def test_users
    role = Role.create(:name => 'god')
    user = User.create(:name => 'Harry', :role_id => role.id)
    assert_equal([user], role.users)
  end
end
