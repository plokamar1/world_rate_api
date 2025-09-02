class CreateCities < ActiveRecord::Migration[8.0]
  def change
    create_table :cities do |t|
      t.belongs_to :country, index: true, null: false
      t.string :state, index: true, null: false
      t.string :name, null: false
      t.float :rating, null: false, default: 0.0
      t.boolean :calculated, null: false, default: true
      t.timestamps
    end
    add_index :cities, [ :country_id, :name ], unique: true
  end
end
