class Relationship < ActiveRecord::Base
  # validates :relationship_type, :presence => true
  # validates :relationship_type, inclusion: { within: ['parent', 'child', 'spouse'],
  #     message: "%{value} is not a valid relationship" }

  belongs_to :person, class_name: 'Person', foreign_key: 'person_id'
  belongs_to :parent, class_name: 'Person', foreign_key: 'parent_id'
  belongs_to :child, class_name: 'Person', foreign_key: 'child_id'

end
