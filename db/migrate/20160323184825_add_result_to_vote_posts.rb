class AddResultToVotePosts < ActiveRecord::Migration
  def change
    add_column :vote_posts, :result, :boolean, default: true, null: false
  end
end
