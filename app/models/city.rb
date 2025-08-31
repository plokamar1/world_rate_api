# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  state      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint           not null
#
# Indexes
#
#  index_cities_on_country_id           (country_id)
#  index_cities_on_country_id_and_name  (country_id,name) UNIQUE
#  index_cities_on_state                (state)
#
class City < ApplicationRecord
  # Associations
  belongs_to :country
  has_and_belongs_to_many :reviews
  ##
  # Validations
  validates :name, presence: true
  validates_uniqueness_of :name, scope: [:country_id]
end
