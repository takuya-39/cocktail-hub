class Api::V1::PostsController < ActionController::API
  def index
    @posts = Post.all.with_attached_image.order(updated_at: 'DESC')

    render json: @posts.map { |post|
      post.as_json.merge({ image: url_for(post.image) })
    }
  end
end
