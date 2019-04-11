# Creates list of comments, connected to help or lesson entry via postid

require 'dm-core'
require 'dm-migrations'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/tutorhub.db")

class Comment
  include DataMapper::Resource
  property :commentid, Integer, :key=>true
  property :postid, Integer
  property :username, String
  property :description, Text
end
DataMapper.finalize()