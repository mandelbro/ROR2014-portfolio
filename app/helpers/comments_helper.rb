module CommentsHelper

  def approve? comment
    policy(comment).approve?
  end

  def destroy? comment
    policy(comment).destroy?
  end

end
