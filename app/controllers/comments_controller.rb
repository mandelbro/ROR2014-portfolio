class CommentsController < ApplicationController
  before_action :set_comment, only: [:approve, :destroy]
  before_action :set_post, only: [:create, :approve, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  # POST /posts/:post_id/comment
  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    @post.comments << @comment
    current_user.comments << @comment

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # GET /posts/:post_id/comments/:id/approve
  def approve
    authorize @comment, :approve?
    @comment.approved = true
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully approved.' }
      else
        redirect_to @post
      end
    end
  end

  # DELETE /posts/:post_id/comments/:id
  def destroy
    authorize @comment
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment was successfully deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(*policy(@comment || Comment).permitted_attributes)
    end
end
