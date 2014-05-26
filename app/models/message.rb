class Message
  include ActiveModel::Model

  attr_accessor :name, :email, :content

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :content, presence: true, length: { maximum: 500 }

  def initialize attributes = {}
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def send_message
    # Only proceed if the message is valid
    return false if !self.valid?
    # send message here
    email = Messages::Mailer.contact_form_message(self).deliver
    if(email)
      # Send the receipt confirmation email
      Messages::Mailer.message_sent_confirmation(self.email).deliver
      # return the email
      email
    else
      flash[:notice] = "Apologies, something messed up and your email can't be sent at this time. Please try me directly at chris@chrismontes.com."
    end
  end

end
