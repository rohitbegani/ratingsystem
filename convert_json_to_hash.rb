require 'json'

req_hash = File.read("file.txt").split("\n").map do |line|
  			 JSON.parse(line)
		   end

puts req_hash.first