class MailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform params
    @message = Message.new(params)
    @message.send_message
  end

end
