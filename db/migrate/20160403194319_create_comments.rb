class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.string :content, null: false
      t.integer :rating, null: false, default: '0'

      t.timestamps null: false
    end
  end
end
