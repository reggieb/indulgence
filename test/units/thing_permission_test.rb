require_relative '../test_helper'
require 'user'
require 'role'
require 'thing_permission'
#require 'permission'

class ThingPermissionTest < Test::Unit::TestCase
  
  Permission = Indulgence::Permission
  
  def setup
    god = Role.new(:name => 'God')
    mortal = Role.new(:name => 'Mortal')
    @user = User.create(:name => 'Trevor', :role_id => mortal.id)
    @super_user = User.create(:name => 'Jane', :role_id => god.id)
  end
  
  def test_super_user_permissions
    permission = ThingPermission.new(@super_user)
    assert_equal(Permission.all, permission[:create])  
    assert_equal(Permission.all, permission[:read]) 
    assert_equal(Permission.all, permission[:update]) 
    assert_equal(Permission.all, permission[:delete]) 
  end
  
  def test_super_user_permissions
    permission = ThingPermission.new(@user)
    assert_equal(Permission.none, permission[:create])  
    assert_equal(Permission.all, permission[:read]) 
    assert_equal(Permission.none, permission[:update]) 
    assert_equal(Permission.none, permission[:delete]) 
  end
  
  
  def teardown
    User.delete_all
    Role.delete_all
    Thing.delete_all
  end
  
  def make_things
    @users_thing = Thing.create(:one, :owner_id => @user.id)
    @super_users_thing = Thing.create(:two, :owner_id => @super_user.id)
  end
  
end
