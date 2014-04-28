module CommentsHelper

  def create?
    comment = Comment.new
    policy(comment).update?
  end

  def update? comment
    policy(comment).update?
  end

  def destroy? comment
    policy(comment).destroy?
  end

end
