class DropTableOldTables < ActiveRecord::Migration
  def change
    drop_table :states
    drop_table :visitors
  end
end
