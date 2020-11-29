class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[show new create edit update destroy]

  def index
  end

  def show
    set_post
    @comments = @post.comments.page(params[:page]).per(10)
    @comment = Comment.new
    @like = Like.new
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.image.attach(params[:post][:image])

    if @post.save
      redirect_to post_path(@post), notice: '新規投稿しました'
    else
      render :new, notice: '新規投稿に失敗しました'
    end
  end

  def edit
    set_post
  end

  def update
    set_post

    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿を更新しました'
    else
      render :edit, notice: '投稿の編集に失敗しました'
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
