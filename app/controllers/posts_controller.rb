class PostsController < ApplicationController

  before_action :set_post, only: [:destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @paginate = Post.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
    if current_user
      @posts = Post.all if current_user.admin? || current_user.family?
      @posts = @paginate.where(family: 0).all if current_user.user?
    else
		  @posts = @paginate.where(family: 0).all
    end
  end

  def new
    @post = Post.new
  end

  def upvote
    @post = Post.find(params[:post_id])
    @post.upvote
    redirect_to :back
  end

  def downvote
    @post = Post.find(params[:post_id])
    @post.downvote
    redirect_to :back
  end

  def create
    @post = current_user.posts.build(post_params)
		if @post.save
			redirect_to posts_path
    else
      redirect_to new_post_path
		end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def slider
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption, :user_id, :family)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
