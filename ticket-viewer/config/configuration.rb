class Configuration
  def self.api_config
    username = "guoshen137@hotmail.com"
    token = "lk6JHBGESQi3RnZwdhZaj1xtCUFNMnAzO8cKKf82"
    full_token = Base64.strict_encode64("#{username}/token:#{token}")
  end
end
