$:.unshift File.join(File.dirname(__FILE__),'units')
$:.unshift File.join(File.dirname(__FILE__),'lib')
$:.unshift File.join(File.dirname(__FILE__),'..','lib','indulgence')

require 'test/unit'

require 'active_record'
ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database =>  "test/db/test.sqlite3.db"
