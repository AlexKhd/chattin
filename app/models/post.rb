class Post < ActiveRecord::Base
  validates :image, presence: true
  validates :caption, presence: true

  has_attached_file :image, styles: { medium: "640x", thumb: ["120x120#", :jpg] }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user

  def upvote
    update_attribute(:rating, self.rating + 1)
  end

  def downvote
    update_attribute(:rating, self.rating - 1)
  end

  def self.best
    order(rating: :desc).limit(5)
  end
end
