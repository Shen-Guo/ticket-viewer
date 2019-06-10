#!/usr/bin/ruby
require "sinatra/base"
require "httparty"
require_relative "../helpers/api_helper"
require_relative "../helpers/logger_helper"
require_relative "../models/ticket"

class TicketViewer < Sinatra::Application
  get "/" do
    begin
      page_index = 1
      list_page(page_index)
      erb :lists
    rescue => ex
      Log.log_error(ex.message)
      @error_message = ex.message
      erb :error
    end
  end

  get "/lists/:id" do
    begin
      id = params[:id]
      detail_page(id)
      erb :ticket_detail
    rescue => ex
      Log.log_error(ex.message)
      @error_message = ex.message
      erb :error
    end
  end

  get "/lists/pages/:page_index" do
    begin
      page_index = params[:page_index]
      list_page(page_index)
      erb :lists
    rescue => ex
      Log.log_error(ex.message)
      @error_message = ex.message
      erb :error
    end
  end

  def fetch_ticket(res)
    if res.key?("ticket")
      ticket_info = res["ticket"]
      ticket = Ticket.new(ticket_info)
    elsif res.key?("error")
      raise res["error"]
    else
      raise "unknown error from API"
    end
  end

  def fetch_tickets(res)
    if res.key?("tickets")
      tickets_info = res["tickets"]
      @tickets = []
      tickets_info.each do |ticket_info|
        ticket = Ticket.new(ticket_info)
        @tickets << ticket
      end
      @tickets
    elsif res.key?("error")
      raise res["error"]
    else
      raise "unknown error from API"
    end
  end

  def get_user_name(user_id)
    url = "https://shenguo.zendesk.com/api/v2/users/#{user_id}.json"
    res = ApiHelper.get_res_from_api(url)
    name = res["user"]["name"]
  end

  def list_page(page_index)
    @page_index = page_index
    @tickets_display_per_page = 25
    url = "https://shenguo.zendesk.com/api/v2/tickets.json?page=#{@page_index}&per_page=#{@tickets_display_per_page}"

    res = ApiHelper.get_res_from_api(url)
    @tickets = fetch_tickets(res)
    @count = res["count"]
    @pages = (@count.to_f / @tickets_display_per_page).ceil
  end

  def detail_page(id)
    @id = id
    url = "https://shenguo.zendesk.com/api/v2/tickets/#{@id}.json"

    res = ApiHelper.get_res_from_api(url)
    @ticket = fetch_ticket(res)
    @ticket.requester_name = get_user_name(@ticket.requester_id)
  end
end
