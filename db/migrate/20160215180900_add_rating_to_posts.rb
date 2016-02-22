class AddRatingToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :rating, :integer, null: false, default: '0'
  end
end
