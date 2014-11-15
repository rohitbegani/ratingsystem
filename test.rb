require 'json'
require 'data_mapper'
require_relative 'dm.rb'

DataMapper.setup :default, "sqlite://#{Dir.pwd}/ratingsystem.db"

class Initial_Rating
  def initial_rating 
	positiverange4 = ['legendary', 'legend', 'finest', 'insane', 'best'];
	positiverange3 = ['favorite', 'favourite', 'fav', 'delicious', 'awesome', 'perfect', 'perfection', 'perfectly', 'scrumptous'];
	positiverange2 = ['love', 'courteous', 'great', 'generous', 'tasty', 'pleasent', 'polite'];
	positiverange1 = ['like', 'enjoyable', 'enjoy', 'reasonable', 'huge', 'plentiful', 'plenty', 'quick', 'enjoyed', 'fast', 'swift'];
	neutralrange   = ['ok', 'fine', 'good', 'nice', 'gud', 'friendly', 'fresh', 'cheap'];
	negativerange1 = ['crowded', 'lousy', 'slow', 'bad'];
	negativerange2 = ['rude', 'worse', 'undercooked'];
	negativerange3 = ['filthy'];
	negativerange4 = ['worst', 'terrible', 'horrible', 'disgusting'];

	req_hash2 = File.read("test123.json").split("\n").map do |line|
	  			   JSON.parse(line)
			      end	

  	# req_hash3 = File.read("test123.json") do |useful|
  	# 				JSON.parse([votes][useful])
  	# 			end
	id = 1		      
	
	# req_hash3 do |u|
	# 	usefulv = useful
	# end
	req_hash2.each do |r|
	  string = r['text']
	  useful = r['votes']['useful']
	  q = string.downcase.gsub(/[^A-Za-z0-9\s]/,"")
	  words = q.split(" ") 
	  val = 0
	  count = 0
        
        words.each do |w|
		  if positiverange4.include? w
		   	val += 4 
			count += 1
		  elsif positiverange3.include? w
			val += 3
			count += 1
		  elsif positiverange2.include? w
			val += 2
			count += 1
		  elsif positiverange1.include? w
			val += 1
			count += 1
		  elsif neutralrange.include? w
			val += 0
			count += 1
		  elsif negativerange1.include? w
			val -= 1
			count += 1
		  elsif negativerange2.include? w
			val -= 2
			count += 1
		  elsif negativerange3.include? w
			val -= 3
			count += 1	
		  elsif negativerange4.include? w
			val -= 4
			count += 1								
		  end
		end

		if val == 0
		  initialval = 0
		  puts initialval
		else  
	      initialval = val/count.to_f
	      puts initialval
	    end
	    #useful1.to_i = :useful
	    record = Rating.all( :id => id)
	    record.update(:initial_rating => initialval) 
	    if useful == 0 then useful = 1 end
	    usefulval = initialval * useful 
	    record.update(:usefulval => usefulval)
	    puts "useful #{usefulval}"
	    id += 1

    end
  end	
end

 Initial_Rating.new.initial_rating