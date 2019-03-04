class ChangeColumnNames < ActiveRecord::Migration[5.2]
  def change
    rename_column :reservations, :start, :start_time
    rename_column :reservations, :end, :end_time
  end
end
