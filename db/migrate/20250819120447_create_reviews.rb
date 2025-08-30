class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :country, foreign_key: true, index: true
      t.belongs_to :user, foreign_key: true, index: true

      t.text :description, null: false, limit: 500
      t.integer :food_rating, default: 0
      t.integer :nightlife_rating, default: 0
      t.integer :transportation_rating, default: 0
      t.integer :safety_rating, default: 0
      t.integer :days_visited, null: false

      t.integer :total_expenses, default: 100

      t.float :total_rating
      t.float :weight
      t.timestamps
    end
    # Added uniqueness index in order to have 1 review per country by each user
    add_index :reviews, [ :country_id, :user_id ], unique: true
  end
end
