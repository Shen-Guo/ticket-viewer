require "httparty"
require_relative "../config/configuration"

class ApiHelper
  def self.get_res_from_api(url)
    # auth = {:username => "guoshen137@hotmail.com",
    #         :password => "xxxx"}

    # res = HTTParty.get('https://shenguo.zendesk.com/api/v2/tickets.json?per_page=2',
    #                       :basic_auth => auth)

    full_token = Configuration.api_config
    res = HTTParty.get(url, headers: { "Authorization" => "Basic #{full_token}" })
  end

  def self.get_res_from_api_with_username_and_token(url, username, token)
    # username = "guoshen137@hotmail.com"
    # token = "lk6JHBGESQi3RnZwdhZaj1xtCUFNMnAzO8cKKf82"
    full_token = Base64.strict_encode64("#{username}/token:#{token}")
    res = HTTParty.get(url, headers: { "Authorization" => "Basic #{full_token}" })
  end
end
