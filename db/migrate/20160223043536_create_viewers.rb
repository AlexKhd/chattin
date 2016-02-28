class CreateViewers < ActiveRecord::Migration
  def change
    create_table :viewers do |t|
      t.integer :count

      t.timestamps null: false
    end
  end
end
