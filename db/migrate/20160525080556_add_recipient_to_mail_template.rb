class AddRecipientToMailTemplate < ActiveRecord::Migration
  def change
    add_column :mail_templates, :recipient, :string
  end
end
