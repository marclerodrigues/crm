FactoryGirl.define do
  factory :phone do |f|
    f.phone_type "home"
    f.number "555-5555-5555"
    f.contact_id "1"
  end

  factory :invalid_phone, parent: :phone do |f|
    f.number nil
    f.contact_id nil
  end
end
