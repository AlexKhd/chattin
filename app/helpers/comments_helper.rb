module CommentsHelper
  def comment_voted?(comment)
    if VoteComment.find_by_user_id_and_comment_id(current_user.id, comment.id)
      VoteComment.find_by_user_id_and_comment_id(current_user.id, comment.id).value
    end
  end
end
