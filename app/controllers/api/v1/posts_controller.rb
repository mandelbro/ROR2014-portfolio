
class Api::V1::PostsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    logger.info request.body.inspect
    if Post.create_from_postmark(Postmark::Mitt.new(request.body.read))
      render text: "Created a post!", status: :created
    else
      render text: "Unauthorized!", status: :unauthorized
    end
  end
end
