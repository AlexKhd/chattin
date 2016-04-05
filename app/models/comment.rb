class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  has_attached_file :image,
    styles: { original: "1024x1024>", medium: "640x", thumb: ["120x120#", :jpg] },
    path: ":rails_root/public:url",
    url: "/system/:class/:attachment/:id_partition/:style/:hash.:extension",
    hash_secret: Rails.application.secrets.secret_paperclip

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
