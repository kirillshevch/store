class AddVisibleToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :visible, :boolean, default: false
  end
end
