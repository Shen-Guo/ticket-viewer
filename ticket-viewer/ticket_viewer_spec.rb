ENV["APP_ENV"] = "test"

require_relative "controllers/tickets_controller"
require "test/unit"
require "rack/test"

# class TicketControllerTest < Test::Unit::TestCase
#   include Rack::Test::Methods

#   def app
#     Sinatra::Application
#   end

#   # def test_it_show_list
#   #   get "/"
#   #   assert last_response.ok?
#   #   assert_equal "list.erb", last_response.body
#   # end

# end

describe "Ticket Viewer" do
  include Rack::Test::Methods

  def app
    TicketController.new
  end
end
it "displays home page" do
  get "/"
end
