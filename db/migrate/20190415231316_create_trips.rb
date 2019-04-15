class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.integer :cost
      t.integer :rating
      t.datetime :date

      t.timestamps
    end
  end
end
