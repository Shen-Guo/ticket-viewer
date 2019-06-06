

def list_page(page_index)
  @page_index = page_index
  @tickets_display_per_page = 25
  url = "https://shenguo.zendesk.com/api/v2/tickets.json?page=#{@page_index}&per_page=#{@tickets_display_per_page}"

  res = ApiHelper.get_res_from_api(url)
  @tickets = handle_tickets(res)
  @count = res["count"]
  @pages = (@count.to_f / @tickets_display_per_page).ceil
end

def detail_page(id)
  @id = id
  url = "https://shenguo.zendesk.com/api/v2/tickets/#{@id}.json"

  res = ApiHelper.get_res_from_api(url)
  @ticket = handle_ticket(res)
end
