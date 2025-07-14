class User < ApplicationRecord
  has_secure_password

  belongs_to :city   # ✅ ← C'est cette ligne qui manque

  has_many :gossips
  has_many :comments
  has_many :likes

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true
end


  

