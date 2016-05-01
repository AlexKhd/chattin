class PostsController < ApplicationController
  include PostsHelper
  attr_accessor :vote_btn_class

  before_action :set_post, only: [:destroy, :show]
  before_action :authenticate_user!, except: [:index, :upvote, :downvote, :show]
  before_action :get_vote_btn_class

  respond_to :html
  respond_to :js

  def index
    @posts_best = Post.best
    @paginate = Post.paginate(
      page: params[:page], per_page: 5
    ).order(created_at: :desc)
    if current_user
      @posts = @paginate.all if current_user.admin? || current_user.family?
      @posts = @paginate.where(family: 0).all if current_user.user?
    else
      @posts = @paginate.where(family: 0).all
    end
  end

  def new
    @post = Post.new
  end

  def upvote
    if current_user
      @post = Post.find(params[:post_id])
      unless vote_result(@post) # user isn't allowed to vote twice
        @vote_post = current_user.vote_posts.build(value: 1, post: @post)
        @vote_post.save
        @post.upvote
      end
      respond_with(@post)
    else
      # redirect_to new_user_session_path, notice: 'Register first.'
      render js: "window.location = '#{new_user_session_path}';"
    end
  end

  def downvote
    if current_user
      @post = Post.find(params[:post_id])
      unless vote_result(@post)
        @vote_post = current_user.vote_posts.build(value: -1, post: @post)
        @vote_post.save
        @post.downvote
      end
      respond_with(@post)
    else
      render js: "window.location = '#{new_user_session_path}';"
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
    @post.destroy
    respond_with @task
  end

  def slider
    @posts = Post.all
  end

  def show
    @comments = @post.comments.paginate(page: params[:page], per_page: 5)
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption, :user_id, :family)
  end

  def set_post
    @post = Post.friendly.find(params[:id])
    if @post.family?
      redirect_to root_path, notice: t(:access_denied) if current_user && current_user.role == 'user'
      redirect_to root_path, notice: t(:access_denied) if !current_user
    end
  end

  def get_vote_btn_class
    current_user ? @vote_btn_class = 'btn_vote' : @vote_btn_class = 'btn_vote opacity4'
  end
end
