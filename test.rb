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
			      end	

  	id = 1		   

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
	    
    end
  end

  def final_val
  		id = 1
  		v = 0
  		a = 0

  		

  		final_rating = 0
  		last_id = Rating.last.id

      for i in 1..2

        recordn = Rating.get(id).business_id
  		recordall = Rating.all(:business_id => recordn)
  		   

  		  recordall.each do |e|
	  		v += e.useful
	  		a += e.usefulval 
	  		final_rating = a/v
          
      end

      	x = final_rating

	    ###Adding formula to scale and extract exact rating #Check veracity of formula
	    ### Why is this <> not working?
	    if -4 < x < -3.5
	    	rating_integer = 1
	    elsif -3.5 < x < -2.5
	    	rating_integer = 1.5
	    elsif -2.5 < x < -1.5
	    	rating_integer = 2
	    elsif -1.5 < x < 0.5
	    	rating_integer = 2.5
	    elsif 0.5 < x < 1.5
	    	rating_integer = 3
	    elsif 1.5 < x < 2.5
	    	rating_integer = 3.5
	    elsif 2.5 < x < 3.5
	    	rating_integer = 4
	    elsif 3.5 < x < 4.5
	    	rating_integer = 4.5
	    else
	    	rating_integer = 5
	    end
	    		
	    ###Formula Complete	
	    		
	    id += 1
	    z = usefulval % 1
	    if z != 0
	    	decimal_val = z * 10
	    	decimal_scaled = (decimal_val % 10)/10
	    	integer_scaled = z - decimal_val
	    	rating_decimal = (z/2)
	    	rating = rating_integer + rating_decimal
	    end

	  		new_rating = Business.new
	  		new_rating.business_id = recordn
	  		new_rating.final_rating = final_rating
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