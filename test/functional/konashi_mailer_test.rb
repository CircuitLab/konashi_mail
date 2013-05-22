require 'test_helper'

class KonashiMailerTest < ActionMailer::TestCase
  test "help" do
    mail = KonashiMailer.help
    assert_equal "Help", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
