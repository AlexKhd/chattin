class CreateVoteComments < ActiveRecord::Migration
  def change
    create_table :vote_comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :comment, index: true, foreign_key: true
      t.integer :value, default: 1, null: false

      t.timestamps null: false
    end
  end
end
