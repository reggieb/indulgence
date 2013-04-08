require_relative '../test_helper'
require 'user'
require 'thing'

class ThingTest < Test::Unit::TestCase
  
  def setup
    @god = Role.create(:name => 'god')
    @owner = User.create(:name => 'Mary')
    @thing = Thing.create(:name => 'Stuff', :owner_id => @owner.id)
  end

  
  def test_user
    assert_equal(@owner, @thing.owner)
    assert_equal([@thing], @owner.things) 
  end
  
  def test_indulge
    assert_equal(true, @thing.indulge?(@owner, :read))
    assert_equal(false, @thing.indulge?(@owner, :delete))
  end
  
  def test_indulge_by_god
    @owner.update_attribute(:role_id, @god.id)
    assert_equal(true, @thing.indulge?(@owner, :read))
    assert_equal(true, @thing.indulge?(@owner, :delete))    
  end
  
  def teardown
    Role.delete_all
    User.delete_all
    Thing.delete_all
  end
  
end
