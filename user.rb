# Creates User table

require 'dm-core'
require 'dm-migrations'
require 'data_mapper'
require 'bcrypt'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/tutorhub.db")

class User
  include DataMapper::Resource
  property :username, String, :key=>true
  property :password, Text
  property :major, String
  property :about, Text
end
DataMapper.finalize()