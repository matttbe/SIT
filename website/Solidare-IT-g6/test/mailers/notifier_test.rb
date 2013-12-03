require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "admin_validated" do
    mail = Notifier.admin_validated
    assert_equal "Admin validated", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
