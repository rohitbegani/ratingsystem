require 'json'

req_hash = File.read("test123.json").split("\n").map do |line|
  			 JSON.parse(line)
		   end

a = req_hash.first

puts a['business_id']                  

# Do same for whatever you may want to retrieve from the hash.