require_relative '../test_helper'
require 'user'
require 'role'

class UserTest < Minitest::Test
  def teardown
    User.delete_all
    Role.delete_all
  end
  
  def test_create
    user = User.create(:name => 'Bob')
    assert_equal(user, User.find_by_name('Bob'))
  end
  
  def test_role
    role = Role.create(:name => 'god')
    user = User.create(:name => 'Harry', :role_id => role.id)
    assert_equal(role, user.role)
  end
end
