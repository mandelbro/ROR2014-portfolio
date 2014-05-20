class Messages::Mailer < ActionMailer::Base

  default from: 'chris@chrismontes.com', to: 'montesc810@gmail.com'

  def contact_form_message(message)
    @message = message
    mail(:subject => "New Contact Form Submission", to: 'chris@chrismontes.com')
  end

  def message_sent_confirmation email
    mail(subject: "Thanks for your messsage", to: email)
  end
end
