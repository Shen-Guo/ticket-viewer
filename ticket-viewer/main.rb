     
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'httparty'
require 'uri'

get '/' do
  username = "guoshen137@hotmail.com"
  token = "lk6JHBGESQi3RnZwdhZaj1xtCUFNMnAzO8cKKf82"
  
  full_token = Base64.strict_encode64("#{username}/token:#{token}")
  
  @tickets_display_per_page = 25
  res = HTTParty.get("https://shenguo.zendesk.com/api/v2/tickets.json?per_page=#{@tickets_display_per_page}",headers: {"Authorization"=> "Basic #{full_token}"})
  
  @tickets = res["tickets"]
  @count = res["count"]
  @pages = (@count.to_f/@tickets_display_per_page).ceil
  # binding.pry
  
 
  erb :lists
end

get "/lists/:id" do
  username = "guoshen137@hotmail.com"
  token = "lk6JHBGESQi3RnZwdhZaj1xtCUFNMnAzO8cKKf82"
  
  full_token = Base64.strict_encode64("#{username}/token:#{token}")
  @id = params[:id]
  res = HTTParty.get("https://shenguo.zendesk.com/api/v2/tickets/#{@id}.json",
  headers: {"Authorization"=> "Basic #{full_token}"})
  @ticket =res["ticket"]
 
  
  erb :ticket_detail

end

get '/lists/pages/:page_index' do
  username = "guoshen137@hotmail.com"
  token = "lk6JHBGESQi3RnZwdhZaj1xtCUFNMnAzO8cKKf82"
  
  full_token = Base64.strict_encode64("#{username}/token:#{token}")
  @page_index = params[:page_index]
  tickets_display_per_page = 25
  url ="https://shenguo.zendesk.com/api/v2/tickets.json?page=#{@page_index}&per_page=#{tickets_display_per_page}"
  res = HTTParty.get(url,headers: {"Authorization"=> "Basic #{full_token}"})
  @tickets = res["tickets"]
  @count = res["count"]
  erb :lists
end



