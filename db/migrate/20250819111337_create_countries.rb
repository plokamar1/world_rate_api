class CreateCountries < ActiveRecord::Migration[8.0]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.float :rating, null: false, default: 0.0
      t.boolean :calculate_rating, null: false, default: false
      t.timestamps
    end
  end
end
