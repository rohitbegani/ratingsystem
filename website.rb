require 'sinatra'
require 'json'
require 'haml'


get '/' do
	haml :index
end

get '/crawl' do
  	haml :crawl
end