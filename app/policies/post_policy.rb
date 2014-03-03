class PostPolicy
  attr_accessor :user, :post

  def initialize(user = nil, post = nil)
    @user = user
    @post = post
  end

  def publish?
    @user.role == 'editor'
  end
end
