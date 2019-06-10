require "minitest/autorun"
require_relative "../helpers/api_helper"

class ApiHelperTest < MiniTest::Unit::TestCase
  def test_valid_response_for_ticket
    url = "https://shenguo.zendesk.com/api/v2/tickets/1.json"
    assert_equal true, ApiHelper.get_res_from_api(url).key?("ticket")
  end

  def test_valid_response_for_ticket
    url = "https://shenguo.zendesk.com/api/v2/tickets.json"
    assert_equal true, ApiHelper.get_res_from_api(url).key?("tickets")
  end

  def test_valid_response_for_user
    url = "https://shenguo.zendesk.com/api/v2/users/381290246113.json"
    assert_equal true, ApiHelper.get_res_from_api(url).key?("user")
  end

  def test_cannot_authenticate
    url = "https://shenguo.zendesk.com/api/v2/tickets.json"
    assert_equal true, ApiHelper.get_res_from_api_with_username_and_token(url, "hello", 123).key?("error")
  end
end
