require 'spec_helper'
require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { FactoryGirl.build(:contact)}

  it "has a valid factory" do
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact.first_name = nil
    expect(contact).not_to be_valid
  end

  it "is invalid without a lastname" do
    contact.last_name = nil
    expect(contact).not_to be_valid
  end

  it "returns a contact's full name as a string" do
    string_name = contact.first_name +  " " + contact.last_name
    expect(contact.name).to eq(string_name)
  end
end
