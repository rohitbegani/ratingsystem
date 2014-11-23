# require 'dm-core'
require 'data_mapper'

DataMapper.setup :default, "sqlite://#{Dir.pwd}/ratingsystem.db"

class Rating
  include DataMapper::Resource
  
  property :id            , Serial
  property :business_id   , String
  property :useful        , Integer
  property :initial_rating , Float 
  property :usefulval	   , Float 
  # property :finalval       , Float
  property :business_name  , String
  
end

class Business
  include DataMapper::Resource

  property :id           , Serial
  property :business_id  , String
  property :final_rating , Float
end  

DataMapper.auto_upgrade!
