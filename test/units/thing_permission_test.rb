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
    @original_role_name = Permission.role_method
    @original_role_name_method = Permission.role_name_method
  end
  
  def test_super_user_permissions
    assert_equal Permission.all, ThingPermission.new(@super_user, :create).ability 
    assert_equal Permission.all, ThingPermission.new(@super_user, :read).ability 
    assert_equal Permission.all, ThingPermission.new(@super_user, :update).ability 
    assert_equal Permission.all, ThingPermission.new(@super_user, :delete).ability 
  end
  
  def test_default_permissions
    assert_equal Permission.none, ThingPermission.new(@user, :create).ability  
    assert_equal Permission.all, ThingPermission.new(@user, :read).ability 
    assert_equal Permission.none, ThingPermission.new(@user, :update).ability
    assert_equal Permission.none, ThingPermission.new(@user, :delete).ability 
  end
  
  def test_role_name
    assert_equal @super_user.role.name.to_sym, ThingPermission.new(@super_user, :read).role_name
  end
  
  def test_role_name_when_not_defined_in_permissions
    assert_equal :default, ThingPermission.new(@user, :read).role_name
  end
  
  def test_setting_unknown_role_method_causes_error
    Permission.role_method = :something_else
    assert_raise NoMethodError do
      ThingPermission.new(@super_user, :read).role_name
    end
  end
  
  def test_setting_role_method
    Permission.role_method = :position
    test_super_user_permissions
  end
  
  def test_setting_unknown_role_name_method_causes_error
    Permission.role_name_method = :something_else
    assert_raise NoMethodError do
      ThingPermission.new(@super_user, :read).role_name
    end
  end
  
  def test_setting_role_name_method
    Permission.role_name_method = :title
    test_super_user_permissions
  end
  
  def test_with_unspecified_ability
    assert_raise Indulgence::AbilityNotFound do
      ThingPermission.new(@user, :unspecified)
    end
  end
  
  def teardown
    User.delete_all
    Role.delete_all
    Thing.delete_all
    Permission.role_method = @original_role_name
    Permission.role_name_method = @original_role_name_method
  end
  
  def make_things
    @users_thing = Thing.create(:one, :owner_id => @user.id)
    @super_users_thing = Thing.create(:two, :owner_id => @super_user.id)
  end
  
end
