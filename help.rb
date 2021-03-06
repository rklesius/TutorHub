# Creates help table

require 'dm-core'
require 'dm-migrations'
require 'data_mapper'
require 'bcrypt'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/tutorhub.db")

class Help
  include DataMapper::Resource
  property :helpid, Integer, :key=>true
  property :title, String
  property :description, Text
  property :category, String
  property :username, String
  property :resolved, Boolean
end
DataMapper.finalize()