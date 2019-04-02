# Creates lessons table

require 'dm-core'
require 'dm-migrations'
require 'data_mapper'
require 'bcrypt'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/tutorhub.db")

class Lesson
  include DataMapper::Resource
  property :title, String
  property :description, String
  property :category, String
  property :username, String
  property :date, DateTime
  property :location, String
end
DataMapper.finalize()