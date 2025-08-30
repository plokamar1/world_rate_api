class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_attributes(auth_object = nil)
    column_names.reject { |c| c.ends_with?("_id") }
  end

  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map(&:name)
  end
end
