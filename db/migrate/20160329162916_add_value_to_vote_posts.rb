class AddValueToVotePosts < ActiveRecord::Migration
  def change
    add_column :vote_posts, :value, :integer, default: 0, null: false
  end
end
