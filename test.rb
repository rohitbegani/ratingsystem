string = "I'm sorry, I'm Legend #legend
          extremely busy right now. I just 
          looked at the clock, and it's 12:54 AM,
          I've still got a lot of work to do. 
          Don't worry about the event tomorrow, 
          it's been moved ahead a week, the 28th of december.
          Remember though, you've got to call to get a ticket 
          soon, their # is 212-323-1239 and they live at Los 
          Angeles, or call the toll free number 1-800-567-4321.
          Their website says it costs $23 per person."

positiverange4 = ['legendary', 'legend', 'finest', 'insane', 'best'];
positiverange3 = ['favorite', 'favourite', 'fav', 'delicious', 'awesome', 'perfect', 'perfection', 'perfectly', 'scrumptous'];
positiverange2 = ['love', 'courteous', 'great', 'generous', 'tasty', 'pleasent', 'polite'];
positiverange1 = ['like', 'enjoyable', 'enjoy', 'reasonable', 'huge', 'plentiful', 'plenty', 'quick', 'enjoyed', 'fast', 'swift'];
neutralrange   = ['ok', 'fine', 'good', 'nice', 'gud', 'friendly', 'fresh', 'cheap'];
negativerange1 = ['crowded', 'lousy', 'slow', 'bad'];
negativerange2 = ['rude', 'worse', 'undercooked'];
negativerange3 = ['filthy'];
negativerange4 = ['worst', 'terrible', 'horrible', 'disgusting'];

q = string.downcase.gsub(/[^A-Za-z0-9\s]/,"")
words = q.split(" ") 
#q = words.downcase

# q.each do |w|
#      w.downcase
# end

puts words

# words2.each do |t|
#   words.each do |u|
#   	if t == u
#   		puts "#{t}"
#   	end	
#   end		
# end