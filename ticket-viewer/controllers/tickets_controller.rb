require 'httparty'
require_relative '../models/Ticket'
require_relative '../helpers/api_helper'

get '/' do
  page_index = 1
  list_page(page_index)
end

get "/lists/:id" do
  
  id = params[:id]
  detail_page(id)

end

get '/lists/pages/:page_index' do
  
  page_index = params[:page_index]
  list_page(page_index)
end




def handle_ticket(res) 
  ticket_info = res["ticket"]
  ticket = Ticket.new(ticket_info)

end

def handle_tickets(res)
  tickets_info = res["tickets"]
  @tickets = []
  tickets_info.each do |ticket_info|
    ticket = Ticket.new(ticket_info)
    @tickets << ticket
  end
  @tickets 
end

def list_page(page_index)
  @page_index = page_index
  @tickets_display_per_page = 25
  url="https://shenguo.zendesk.com/api/v2/tickets.json?page=#{@page_index}&per_page=#{@tickets_display_per_page}"

  res = ApiHelper.get_res_from_api(url)
  @tickets = handle_tickets(res)
  
  @count = res["count"]
  @pages = (@count.to_f/@tickets_display_per_page).ceil
 
  erb :lists

end
def detail_page(id)
  @id = id
  url = "https://shenguo.zendesk.com/api/v2/tickets/#{@id}.json"

  res =ApiHelper.get_res_from_api(url)
  @ticket = handle_ticket(res)
 
  erb :ticket_detail

end