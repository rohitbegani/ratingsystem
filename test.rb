require 'json'
require 'data_mapper'
require_relative 'dm.rb'

DataMapper.setup :default, "sqlite://#{Dir.pwd}/ratingsystem.db"

# module RatingSystem
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
			      end	                                # Reading the Json File and creating 
			      										# an array of hash of each record.

  	id = 1		   

	req_hash2.each do |r|
	  string = r['text']								# Getting required attributes from 
	  useful = r['votes']['useful']                     # the hash and splitting the words 
	  q = string.downcase.gsub(/[^A-Za-z0-9\s]/,"")     # to create an array of words. 
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
			val += 1                                     # Assigning the value to 'val' and 'count'
			count += 1                                   # based on the range in which a 
		  elsif neutralrange.include? w                  #particular word lies.
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
		else  
	      initialval = val/count.to_f
	    end

	    
	    record = Rating.all( :id => id)
	    record.update(:initial_rating => initialval)    # Updating the DB with the useful
	    if useful == 0 then useful = 1 end              # value calculated by multiplying
	    usefulval = initialval * useful                 # initialval with useful
	    record.update(:usefulval => usefulval)
	    puts "useful #{usefulval}"
	    id += 1

    end
  end                                                  # End of initial_rating method



  
  def final_val
  	id = 1
  	v = 0
  	a = 0
    final_rating = 0
  	last_id = Rating.last.id

    for i in 1..2                                         # i loops n(number of restaurants) times
      recordn = Rating.get(id).business_id				  # n is 2 here
  	  recordall = Rating.all(:business_id => recordn)
  		 
  		 recordall.each do |e|
	  	   v += e.useful
	  	   a += e.usefulval 
	  	   final_rating = a/v
         end

         x = final_rating

         if x > -4 and x < -3.5
	    	rating_integer = 1
	     elsif x > -3.5 and x < -2.5
	    	rating_integer = 1.5
	     elsif x > -2.5 and x < -1.5
	    	rating_integer = 2
	     elsif x > -1.5 and x < 0.5
	    	rating_integer = 2.5
	     elsif x > 0.5 and x < 1.5
	    	rating_integer = 3
	     elsif x > 1.5 and x < 2.5
	    	rating_integer = 3.5
	     elsif x > 2.5 and x < 3.5
	    	rating_integer = 4
	     elsif x > 3.5 and x < 4.5
	    	rating_integer = 4.5
	     else
	    	rating_integer = 5
	     end

	     z = final_rating % 1
	      
	     if z != 0
	       decimal_val = z * 10
	       decimal_scaled = (decimal_val % 10)/10
	       integer_scaled =  final_rating - decimal_val
	       rating_decimal = (decimal_scaled/2)
	       rating = rating_integer + rating_decimal
	     end

	  	 new_rating = Business.new
	  	 new_rating.business_id  = recordn
	  	 new_rating.final_rating = rating
	  	 new_rating.save
	  	 
	  	 last_business_id = recordn
	  	 last_id_of_group = recordall.last.id
	  	 id = last_id_of_group + 1 	  
	 	 puts "id -> #{id}"
	end	  
	  		
  end	
end

# end

 Initial_Rating.new.initial_rating
 Initial_Rating.new.final_val