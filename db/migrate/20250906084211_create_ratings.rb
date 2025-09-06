class CreateRatings < ActiveRecord::Migration[8.0]
  def change
    create_table :ratings do |t|
      t.bigint  :ratable_id, null: false
      t.string  :ratable_type, null: false

      t.integer :food_rating, default: 0
      t.integer :nightlife_rating, default: 0
      t.integer :transportation_rating, default: 0
      t.integer :safety_rating, default: 0
      t.integer :nature_rating, default: 0
      t.integer :sightseeing_rating, default: 0

      t.float :total_rating

      t.timestamps
    end
  end
end
