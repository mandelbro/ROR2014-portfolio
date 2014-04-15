module CommentsHelper

  def update? comment
    policy(comment).update?
  end

  def destroy? comment
    policy(comment).destroy?
  end

end
