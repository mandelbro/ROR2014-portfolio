module PostsHelper

  def create?
    policy(Post.new).create?
  end

  def publish? post
    policy(post).publish?
  end

  def update? post
    policy(post).update?
  end

  def destroy? post
    policy(post).update?
  end

  def comment? post
    policy(post).comment?
  end

end
