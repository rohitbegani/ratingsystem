require 'sinatra'
require 'json'
require 'haml'


get '/' do
 "hi wassup?"
end

get '/crawl' do
  "crawl the shit out of this app."
end