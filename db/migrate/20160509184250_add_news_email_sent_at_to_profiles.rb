class AddNewsEmailSentAtToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :news_email_sent_at, :datetime
  end
end
