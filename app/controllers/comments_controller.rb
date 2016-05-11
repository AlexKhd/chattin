class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :js

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save!
    redirect_to(:back)

    # respond_to do |format|
    #  if @comment.save
    #    format.html { redirect_to @comment, notice: 'Comment created.' }
    #    format.json { render :show, status: :created, location: @comment }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @comment.errors,
    # status: :unprocessable_entity }
    #  end
    # end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post = Post.friendly.find(params[:post_id])
    @comment.destroy
    redirect_to post_path(@post)
    # respond_to do |format|
    #  format.html { redirect_to comments_url, notice: 'Comment destroyed.' }
    #  format.json { head :no_content }
    # end
  end

  def upvote
    if current_user
      @comment = Comment.find(params[:comment_id])
      profile = Profile.find(@comment.user_id)
      #unless vote_result(@post) # user isn't allowed to vote twice
      #  @vote_post = current_user.vote_posts.build(value: 1, post: @post)
      #  @vote_post.save
        @comment.upvote(profile)
      #end
      respond_with(@comment)
    else
      render js: "window.location = '#{new_user_session_path}';"
    end
  end

  def downvote
    if current_user
      @comment = Comment.find(params[:comment_id])
      profile = Profile.find(@comment.user_id)
      #unless vote_result(@post) # user isn't allowed to vote twice
      #  @vote_post = current_user.vote_posts.build(value: 1, post: @post)
      #  @vote_post.save
        @comment.downvote(profile)
      #end
      respond_with(@comment)
    else
      render js: "window.location = '#{new_user_session_path}';"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content, :image)
  end
end
