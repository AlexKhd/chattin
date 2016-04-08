module PostsHelper
  def vote_result(post)
    if VotePost.find_by_user_id_and_post_id(current_user.id, post.id)
      VotePost.find_by_user_id_and_post_id(current_user.id, post.id).value
    end
  end
end
