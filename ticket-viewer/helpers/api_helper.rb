require "httparty"
require_relative "../config/configuration"

class ApiHelper
  def self.get_res_from_api(url)
    # username = "guoshen137@hotmail.com"
    # token = "lk6JHBGESQi3RnZwdhZaj1xtCUFNMnAzO8cKKf82"
    # full_token = Base64.strict_encode64("#{username}/token:#{token}")
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
