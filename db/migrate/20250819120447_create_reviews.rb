class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :country, foreign_key: true, index: true
      t.belongs_to :user, foreign_key: true, index: true

      t.text :description, null: true, limit: 500
      t.integer :food_rating, limit: 2, default: 0
      t.integer :nightlife_rating, limit: 2, default: 0
      t.integer :culture_rating, limit: 2, default: 0
      t.integer :transportation_rating, limit: 2, default: 0
      t.integer :expenses_rating, limit: 2, default: 0
      t.float :total_rating
      t.timestamps
    end
    # Added uniqueness index in order to have 1 review per country by each user
    add_index :reviews, [ :country_id, :user_id ], unique: true
  end
end
