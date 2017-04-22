class Customer < ApplicationRecord
  before_validation :generate_token
  has_secure_password
  has_many :cards
  validates :email, presence: true
  validates :email, uniqueness: true
  validate :valid_bt_customer

  def generate_token
    self.bt_id = SecureRandom.hex
  end

  def valid_bt_customer
    result = Braintree::Customer.create(
      :id => self.bt_id,
      :first_name => self.username
    )
    unless result.success?
      self.errors.add(:bt_id, :blank, message: "Token is required")
    end
  end
end
