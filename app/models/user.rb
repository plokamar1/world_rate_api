# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  reviews_count        :integer          default(0), not null
#  username             :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  nationality_id       :bigint
#  residence_country_id :bigint
#
# Indexes
#
#  index_users_on_nationality_id        (nationality_id)
#  index_users_on_residence_country_id  (residence_country_id)
#
# Foreign Keys
#
#  fk_rails_...  (nationality_id => countries.id)
#  fk_rails_...  (residence_country_id => countries.id)
#
class User < ApplicationRecord
  has_many :reviews
  belongs_to :nationality, class_name: "Country"
  belongs_to :residence_country, class_name: "Country"
end
