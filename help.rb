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
  property :description, String
  property :category, String
  property :username, String
end

DataMapper.finalize()