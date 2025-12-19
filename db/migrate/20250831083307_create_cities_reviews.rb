class CreateCitiesReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :cities_reviews do |t|
      t.belongs_to :city, index: true, null: false
      t.belongs_to :review, index: true, null: false
    end
  end
end
