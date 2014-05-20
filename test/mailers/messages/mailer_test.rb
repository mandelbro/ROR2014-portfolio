require 'test_helper'

class MessagesMailerTest < ActionMailer::TestCase

  tests Messages::Mailer

  test "messages_email" do

    @message = Message.new(name: 'Test', email: 'montesc810@gmail.com', content: 'Test Content')
    email = @message.send_message
    refute_empty ActionMailer::Base.deliveries

    # Test the body of the sent email contains what we expect it to
    assert_equal ['chris@chrismontes.com'], email.from
    assert_equal ['montesc810@gmail.com'], email.to
    assert_equal 'New Contact Form Submission', email.subject
    assert_equal read_fixture('contact_form_message').join, email.body.to_s

   end

end
