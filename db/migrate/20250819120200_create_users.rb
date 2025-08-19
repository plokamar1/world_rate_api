class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.integer :reviews_count, default: 0, null: false
      t.belongs_to :nationality, foreign_key: { to_table: :countries }, index: true
      t.belongs_to :residence_country, foreign_key: { to_table: :countries }, index: true
      t.timestamps
    end
  end
end
