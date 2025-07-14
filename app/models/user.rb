class User < ApplicationRecord
  has_secure_password

  belongs_to :city

  has_many :gossips
  has_many :comments
  has_many :likes

  has_many :sent_conversations, foreign_key: :sender_id, class_name: 'Conversation'
  has_many :received_conversations, foreign_key: :recipient_id, class_name: 'Conversation'

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  # Ajoute cette méthode
  def full_name
    "#{first_name} #{last_name}"
  end
end




  

