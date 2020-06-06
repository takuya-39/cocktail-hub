class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.image.attach(params[:post][:image])

    if @post.save
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  private

    def post_params
      params.require(:post).permit(:image, :genre, :title, :memo)
    end
end
