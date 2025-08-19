# == Schema Information
#
# Table name: countries
#
#  id               :bigint           not null, primary key
#  calculate_rating :boolean          default(FALSE), not null
#  name             :string           not null
#  rating           :float            default(0.0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Country < ApplicationRecord
  has_many :reviews
  has_many :users
end
