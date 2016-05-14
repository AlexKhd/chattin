class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :vote_comments, dependent: :destroy

  t = '/system/:class/:attachment/:id_partition/:style/:hash.:extension'

  has_attached_file :image,
                    styles: {
                      original: '1024x1024>',
                      medium: '640x',
                      thumb: ['120x120#', :jpg]
                    },
                    path: ':rails_root/public:url',
                    url: t,
                    hash_secret: Rails.application.secrets.secret_paperclip

  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def upvote(profile)
    update_attribute(:rating, self.rating + 1)
    profile.update_attribute(:rating, profile.rating + 1)
  end

  def downvote(profile)
    update_attribute(:rating, self.rating - 1)
    profile.update_attribute(:rating, profile.rating - 1)
  end
end
