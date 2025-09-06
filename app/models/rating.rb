# == Schema Information
#
# Table name: ratings
#
#  id                    :bigint           not null, primary key
#  food_rating           :integer          default(0)
#  nature_rating         :integer          default(0)
#  nightlife_rating      :integer          default(0)
#  ratable_type          :string
#  safety_rating         :integer          default(0)
#  sightseeing_rating    :integer          default(0)
#  total_rating          :float
#  transportation_rating :integer          default(0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  ratable_id            :bigint
#
class Rating < ApplicationRecord
  # Associations
  belongs_to :ratable, polymorphic: true


end
