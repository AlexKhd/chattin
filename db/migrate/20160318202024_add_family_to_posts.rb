class AddFamilyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :family, :boolean, default: false
  end
end
