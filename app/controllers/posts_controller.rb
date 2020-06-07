class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    set_post
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
    set_post
  end

  def update
    set_post

    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    set_post
    @post.destroy
    redirect_to root_path
  end

  private

    def post_params
      params.require(:post).permit(:image, :title, :genre, :ingredients, :memo)
    end

    # 特定のPostを@postに代入する
    def set_post
      @post = Post.find_by(id: params[:id])
    end
end
