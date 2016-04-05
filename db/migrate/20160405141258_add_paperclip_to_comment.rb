class AddPaperclipToComment < ActiveRecord::Migration
  def change
    add_attachment :comments, :image
  end
end
