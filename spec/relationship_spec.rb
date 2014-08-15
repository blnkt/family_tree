require 'spec_helper'

describe Relationship do

  it 'marrys two people' do
    earl = Person.create(:first_name => 'Earl', last_name: 'Ford')
    steve = Person.create(:first_name => 'Steve', last_name: 'Ford')
    earl.update(spouse_id: steve.id)
    steve.update(spouse_id: earl.id)
    expect(steve.spouse_id).to eq earl.id
    expect(earl.spouse_id).to eq steve.id
  end

  it 'makes someone a parent and someone a child' do
    earl = Person.create(:first_name => 'Earl', last_name: 'Ford')
    steve = Person.create(:first_name => 'Steve', last_name: 'Ford')
    Relationship.create(person_id: steve.id, parent_id: earl.id)
    Relationship.create(person_id: earl.id, child_id: steve.id)
    expect(earl.children).to eq [steve]
    expect(steve.parents).to eq [earl]
  end
end
