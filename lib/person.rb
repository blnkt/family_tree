class Person < ActiveRecord::Base
  validates :first_name, :last_name, :presence => true

  has_many :relationships, class_name: 'Relationship', foreign_key: 'person_id'
  has_many :parents, through: :relationships
  has_many :children, through: :relationships

  after_save :make_marriage_reciprocal

  def spouse
    if spouse_id.nil?
      nil
    else
      Person.find(spouse_id)
    end
  end

private

  def make_marriage_reciprocal
    if spouse_id_changed?
      spouse.update(:spouse_id => id)
    end
  end
end
