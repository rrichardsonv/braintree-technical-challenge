class Card < ApplicationRecord
  belongs_to :customer

  validates :token, :last_4, presence: true
  validates :token, uniqueness: true
end
