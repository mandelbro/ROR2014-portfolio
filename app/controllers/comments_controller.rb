class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :spam, :destroy]
  before_action :set_post, only: [:create, :update, :spam, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  # POST /posts/:post_id/comment
  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    @comment.junk = @comment.spam?
    @comment.user_agent = request.user_agent
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

  # PATCH /posts/:post_id/comments/:id/approve
  def update
    authorize @comment
    action = params['comment']['action'] || 'updated'
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @post, notice: "Comment was successfully #{action}." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def spam
    authorize @comment, :update?
    @comment.spam!
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment was successfully marked as spam.' }
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
