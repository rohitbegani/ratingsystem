require 'json'
require 'data_mapper'
require_relative 'dm.rb'

DataMapper.setup :default, "sqlite://#{Dir.pwd}/ratingsystem.db"

req_hash = File.read("test123.json").split("\n").map do |line|
  			 JSON.parse(line)
		   end

a = req_hash.each do |r|
	  new_rating = Rating.new
 	  new_rating.business_id =  r['business_id'] 
      new_rating.useful = r[:votes][:useful]
      new_rating.scaled_rating = 5
      new_rating.save 
	end

 