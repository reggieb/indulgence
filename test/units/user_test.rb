require_relative '../test_helper'
require 'user'

class UserTest < Test::Unit::TestCase
  def test_create
    user = User.create(:name => 'Bob')
    assert_equal(user, User.find_by_name('Bob'))
  end
end
