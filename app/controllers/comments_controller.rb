class CommentsController < ApplicationController
  include CommentsHelper
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
    redirect_to :back

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
    redirect_to :back # TODO redirect in case of jump to prev page
    # respond_to do |format|
    #  format.html { redirect_to comments_url, notice: 'Comment destroyed.' }
    #  format.json { head :no_content }
    # end
  end

  def upvote
    if current_user
      @comment = Comment.find(params[:comment_id])
      profile = Profile.find(@comment.user_id)
      unless comment_voted?(@comment) # user isn't allowed to vote twice
        @vote_comment = current_user.vote_comments.build(value: 1, comment: @comment)
        @vote_comment.save
        @comment.upvote(profile)
      end
      respond_with(@comment)
    else
      render js: "window.location = '#{new_user_session_path}';"
    end
  end

  def downvote
    if current_user
      @comment = Comment.find(params[:comment_id])
      profile = Profile.find(@comment.user_id)
      unless comment_voted?(@comment)
        @vote_comment = current_user.vote_comments.build(value: -1, comment: @comment)
        @vote_comment.save
        @comment.downvote(profile)
      end
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
    params.require(:comment).permit(:content, :image)
  end
end
