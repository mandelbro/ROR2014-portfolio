class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.send_message
      flash[:notice] = "Thanks for your message, I'll get back to you as soon as I can."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit([:name, :email, :content])
  end

end
