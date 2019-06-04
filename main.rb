require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'httparty'
require 'uri'

get '/' do
  auth = {:username => "guoshen137@hotmail.com",
          :password => "xxxx"}

  results = HTTParty.get('https://shenguo.zendesk.com/api/v2/tickets.json?per_page=2',
                          :basic_auth => auth)
  
  p results['tickets'].to_s

  erb: lists


end