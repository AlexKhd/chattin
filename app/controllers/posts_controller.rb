class PostsController < ApplicationController

  before_action :set_post, only: [:destroy]
  before_action :authenticate_user!, except: [:index, :upvote, :downvote]

  respond_to :html
  respond_to :js

  def index
    @posts_best = Post.best
    @paginate = Post.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
    if current_user
      @posts = @paginate.all if current_user.admin? || current_user.family?
      @posts = @paginate.where(family: 0).all if current_user.user?
      respond_with(@posts)
    else
		  @posts = @paginate.where(family: 0).all
		  respond_with(@posts)
    end
  end

  def new
    @post = Post.new
  end

  def upvote
    if current_user
      @post = Post.find(params[:post_id])
      #@vote_post = @post.vote_posts.build(vote_post_params)
      #@vote_post.user = current_user
      @post.upvote
      respond_with(@post)
    end
  end

  def downvote
    if current_user
      @post = Post.find(params[:post_id])
      @post.downvote
      respond_with(@post)
    end
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
    #@post = Post.find(params[:id])
    @post.destroy
    #redirect_to posts_path
    respond_with(@task)
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
