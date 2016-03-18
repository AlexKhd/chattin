class Post < ActiveRecord::Base
  validates :image, presence: true
  validates :caption, presence: true

  has_attached_file :image, styles: { :medium => "640x" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user

  def upvote
    update_attribute(:rating, self.rating + 1)
  end

  def downvote
    update_attribute(:rating, self.rating - 1)
  end
end
