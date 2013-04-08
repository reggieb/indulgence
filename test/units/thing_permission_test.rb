require_relative '../test_helper'
require 'user'
require 'role'
require 'thing_permission'

class ThingPermissionTest < Test::Unit::TestCase
  
  Permission = Indulgence::Permission
  
  def setup
    god = Role.create(:name => 'god')
    mortal = Role.create(:name => 'mortal')
    @user = User.create(:name => 'Trevor', :role_id => mortal.id)
    @super_user = User.create(:name => 'Jane', :role_id => god.id)
    @original = ThingPermission.role_method
  end
  
  def test_super_user_permissions
    permission = ThingPermission.new(@super_user)
    assert_equal(Permission.all, permission[:create])  
    assert_equal(Permission.all, permission[:read]) 
    assert_equal(Permission.all, permission[:update]) 
    assert_equal(Permission.all, permission[:delete]) 
  end
  
  def test_default_permissions
    permission = ThingPermission.new(@user)
    assert_equal(Permission.none, permission[:create])  
    assert_equal(Permission.all, permission[:read]) 
    assert_equal(Permission.none, permission[:update]) 
    assert_equal(Permission.none, permission[:delete]) 
  end
  
  def test_role_name
    assert_equal @super_user.role.name.to_sym, ThingPermission.new(@super_user).role_name
  end
  
  def test_role_name_when_not_defined_in_permissions
    assert_equal :default, ThingPermission.new(@user).role_name
  end
  
  def test_setting_unkown_role_method_causes_error
    ThingPermission.role_method = :something_else
    assert_raise NoMethodError do
      ThingPermission.new(@super_user).role_name
    end
  end
  
  def test_setting_role_method
    ThingPermission.role_method = :position
    test_super_user_permissions
  end
  
  
  def teardown
    User.delete_all
    Role.delete_all
    Thing.delete_all
    ThingPermission.role_method = @original
  end
  
  def make_things
    @users_thing = Thing.create(:one, :owner_id => @user.id)
    @super_users_thing = Thing.create(:two, :owner_id => @super_user.id)
  end
  
end
