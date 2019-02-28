class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.time :opens
      t.time :closes

      t.timestamps
    end
  end
end
