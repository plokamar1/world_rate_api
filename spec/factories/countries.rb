# frozen_string_literal: true

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
FactoryBot.define do
  factory :country do
    code { Faker::Address.unique.country_code }
    name { Faker::Address.unique.country }
  end
end
