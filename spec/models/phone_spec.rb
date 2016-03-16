require 'spec_helper'
require 'rails_helper'

RSpec.describe Phone, type: :model do
  let(:phone) { FactoryGirl.build(:phone)}

  it "have a valid factory" do
    expect(phone).to be_valid
  end

  it "is invalid without phone_type" do
    phone.phone_type = nil
    expect(phone).not_to be_valid
  end

  it "is invalid without phone number" do
    phone.number = nil
    expect(phone).not_to be_valid
  end

  it "is invalid without a contact" do
    phone.contact_id = nil
    expect(phone).not_to be_valid
  end
end
