class ChangeRatingTypeInProfiles < ActiveRecord::Migration
  def change
    change_column :profiles, :rating, :decimal, precision: 9, scale: 2
  end
end
