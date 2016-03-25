class VotePost < ActiveRecord::Base

  belongs_to :user
  belongs_to :post

  validates :post_id, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :post_id,
                                    message: I18n.t('already_voted') }

end
