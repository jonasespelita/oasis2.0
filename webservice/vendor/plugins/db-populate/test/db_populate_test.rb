require File.dirname(__FILE__) + '/test_helper.rb'
require 'test/unit'
require 'rubygems'
require 'mocha'

class User < ActiveRecord::Base
end

class DbPopulateTest < Test::Unit::TestCase
  
  def test_creates_new_record
    User.delete_all
    User.create_or_update(:id => 1, :name => "Fred")
    assert_equal User.count, 1
    u = User.find(:first)
    assert_equal u.name, "Fred"
  end
  
  def test_updates_existing_record
    User.delete_all
    User.create_or_update(:id => 1, :name => "Fred")
    User.create_or_update(:id => 1, :name => "George")
    assert_equal User.count, 1
    u = User.find(:first)
    assert_equal u.name, "George"
  end
  
end

