class CreateMailTemplates < ActiveRecord::Migration
  def self.up
    create_table :mail_templates do |t|
      t.text :body
      t.string :subject, :description
      t.string :format, default: :html
      t.string :locale, default: :ru
      t.string :handler, default: :erb

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :mail_templates
  end
end
