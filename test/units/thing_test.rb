require_relative '../test_helper'
require 'user'
require 'thing'

class ThingTest < Test::Unit::TestCase
  def teardown
    User.delete_all
    Thing.delete_all
  end
  
  def test_user
    user = User.create(:name => 'Mary')
    thing = Thing.create(:name => 'Stuff', :owner_id => user.id)
    
    assert_equal(user, thing.owner)
    assert_equal([thing], user.things)
    
  end
  
end
