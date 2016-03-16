class Phone < ActiveRecord::Base
  validates :phone_type, :number, :contact_id, presence: true
  validates :number, uniqueness: { scope: :contact_id}
  belongs_to :contact
end
