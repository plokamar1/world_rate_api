class CreateCountries < ActiveRecord::Migration[8.0]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.float :rating, null: false, default: 0.0
      t.boolean :calculated, null: false, default: true
      t.integer :reviews_count, default: 0, null: false
      t.timestamps
    end
  end
end
