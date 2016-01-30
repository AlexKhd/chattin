class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|

      t.string   "ip_addr"
      t.integer  "conn_count"
      t.string   "country"
      t.string   "city"
      t.string   "comment"
      t.timestamps null: false
    end
  end
end
