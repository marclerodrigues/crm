class Contact < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  has_many :phones

  def name
    [first_name, last_name].join " "
  end
end
