class AddVisibleToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :visible, :boolean, default: false
  end
end
