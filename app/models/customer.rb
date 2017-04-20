class Customer < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :email, uniqueness: true

  def payment_methods
  end

  def default_payment
  end
end
