require_relative '../test_helper'
require 'user'
require 'work_process'
require 'work_process_permission'

class WorkProcessTest < Test::Unit::TestCase
  
  def teardown
    User.delete_all
    WorkProcess.delete_all
  end
  
  def test_indulge_beginning
    {
      create: true,
      read: true,
      update: false,
      delete: true
    }.each do |ability, expected|
    
    assert_equal(
      expected, 
      beginning_process.indulge?(user, ability),
      "User should #{'not ' unless expected}be able to #{ability}"
    )
    end
  end
  
  def test_indulge_middle
    {
      create: false,
      read: true,
      update: true,
      delete: true
    }.each do |ability, expected|
    
    assert_equal(
      expected, 
      middle_process.indulge?(user, ability),
      "User should #{'not ' unless expected}be able to #{ability}"
    )
      
    end
  end
  
  def test_indulgence
    expected = [beginning_process]
    assert_equal expected, WorkProcess.indulgence(user, :create, :beginning)
  end
  
  def test_indulgence_when_not_permitted
    assert_raise ActiveRecord::RecordNotFound do
      WorkProcess.indulgence(user, :update, :beginning)
    end
  end
  
  def user
    @user ||= User.create(:name => 'Bob')
  end
  
  def beginning_process
    @beginning_process ||= create_process(:beginning)
  end
  
  def middle_process
    @middle_process ||= create_process(:middle)
  end
  
  def finist_process
    @finish_process ||= create_process(:finist)
  end
  
  def create_process(stage)
    WorkProcess.create(
      name: "#{stage} process",
      stage: stage.to_s
    )
  end
end
