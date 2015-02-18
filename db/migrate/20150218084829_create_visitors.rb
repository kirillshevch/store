class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|

      t.timestamps
    end
  end
end
