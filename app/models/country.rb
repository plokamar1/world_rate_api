# == Schema Information
#
# Table name: countries
#
#  id            :bigint           not null, primary key
#  calculated    :boolean          default(TRUE), not null
#  code          :string           not null
#  name          :string           not null
#  rating        :float            default(0.0), not null
#  reviews_count :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Country < ApplicationRecord
  ##
  # TODO:
  # - Add cities that belong to countries.
  # - The reviews should belong to a city not a country and the country will have association through the cities
  #
  ##
  # Associations
  has_many :reviews
  has_many :cities
  has_many :residents, class_name: "User", foreign_key: :residence_country_id
  has_many :natives, class_name: "User", foreign_key: :nationality_id
  ##
  # Validations
  validates :code, :name, :calculated, :rating, :reviews_count, presence: true
  validates_uniqueness_of :name, :code
end
