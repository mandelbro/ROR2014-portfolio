class AkismetWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :akismet, :retry => 3

  def perform comment_id
    @comment = Comment.find(comment_id)
    @comment.junk = @comment.spam?
    @comment.save
  end

end
