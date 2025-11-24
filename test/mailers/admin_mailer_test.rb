require "test_helper"

class AdminMailerTest < ActionMailer::TestCase
  test "pending_order_summary" do
    mail = AdminMailer.pending_order_summary
    assert_equal "Pending order summary", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
