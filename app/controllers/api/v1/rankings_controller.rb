class Api::V1::RankingsController < ActionController::API
  def index
    @posts = Post.limit(3).includes(:liked_users).sort { |a, b| b.liked_users.size <=> a.liked_users.size }

    render json: @posts.map { |post|
      post.as_json.merge({ image: url_for(post.image) })
    }
  end
end
