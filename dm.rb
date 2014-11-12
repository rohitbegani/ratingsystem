# require 'dm-core'
require 'data_mapper'

DataMapper.setup :default, "sqlite://#{Dir.pwd}/ratingsystem.db"

class Rating
  include DataMapper::Resource
  
  property :id            , Serial
  property :business_id   , String
  property :useful        , Integer
  property :scaled_rating , Integer 
  
end

DataMapper.auto_upgrade!
