class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :table, foreign_key: true
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
