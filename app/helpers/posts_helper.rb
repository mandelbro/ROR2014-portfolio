module PostsHelper

  def publish? post, user = current_user
    PostPolicy.new(user, post).publish?
  end
end
