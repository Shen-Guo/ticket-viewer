require "minitest/autorun"
require_relative "../models/ticket"
require "json"

class TicketTest < MiniTest::Unit::TestCase
  def test_ticket
    json = '{ "url": "https://shenguo.zendesk.com/api/v2/tickets/1.json",
      "id": 1,
      "external_id": null,
      "via": { "channel": "sample_ticket",
               "source": { "from": {}, "to": {}, "rel": null } },
      "created_at": "2019-06-03T11:35:23Z",
      "updated_at": "2019-06-03T11:35:24Z",
      "type": "incident",
      "subject": "Sample ticket: Meet the ticket",
      "raw_subject": "Sample ticket: Meet the ticket",
      "description": "Hi Shen,\n\nThis is your first ticket. Ta-da! Any customer request sent to your supported channels (email, chat, voicemail, web form, and tweet) will become a Support ticket, just like this one. Respond to this ticket by typing a message above and clicking Submit. You can also see how an email becomes a ticket by emailing your new account, support@shenguo.zendesk.com. Your ticket will appear in ticket views.\n\nThat\'s the ticket on tickets. If you want to learn more, check out: \nhttps://support.zendesk.com/hc/en-us/articles/203691476\n", "priority": "normal",
      "status": "open",
      "recipient": null,
      "requester_id": 381290246113,
      "submitter_id": 381277065553,
      "assignee_id": 381277065553,
      "organization_id": null,
      "group_id": 360004508433,
      "collaborator_ids": [],
      "follower_ids": [],
      "email_cc_ids": [],
      "forum_topic_id": null,
      "problem_id": null,
      "has_incidents": false,
      "is_public": true,
      "due_at": null,
      "tags": ["sample", "support", "zendesk"],

      "custom_fields": [],
      "satisfaction_rating": null,
      "sharing_agreement_ids": [],
      "fields": [],
      "followup_ids": [],
      "brand_id": 360002608113,
      "allow_channelback": false,
      "allow_attachments": true }'

    ticket = Ticket.new(JSON.parse(json))

    assert_equal 1, ticket.id
    assert_equal "Sample ticket: Meet the ticket", ticket.subject
    assert_equal 381277065553, ticket.submitter_id
    assert_equal 381290246113, ticket.requester_id
    assert_equal "Hi Shen,\n\nThis is your first ticket. Ta-da! Any customer request sent to your supported channels (email, chat, voicemail, web form, and tweet) will become a Support ticket, just like this one. Respond to this ticket by typing a message above and clicking Submit. You can also see how an email becomes a ticket by emailing your new account, support@shenguo.zendesk.com. Your ticket will appear in ticket views.\n\nThat\'s the ticket on tickets. If you want to learn more, check out: \nhttps://support.zendesk.com/hc/en-us/articles/203691476\n", ticket.description
  end
end
