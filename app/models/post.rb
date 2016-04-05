class Post < ActiveRecord::Base
  validates :image, presence: true
  validates :caption, presence: true

  has_attached_file :image,
    styles: { original: "1024x1024>", medium: "640x", thumb: ["120x120#", :jpg] },
    path: ":rails_root/public:url",
    url: "/system/:class/:attachment/:id_partition/:style/:hash.:extension",
    hash_secret: Rails.application.secrets.secret_paperclip

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :user
  has_many :vote_posts, dependent: :destroy
  has_many :comments, dependent: :destroy

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
