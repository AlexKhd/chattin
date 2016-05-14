class VoteComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment

  validates :comment_id, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :comment_id,
                                    message: I18n.t('already_voted') }
end
