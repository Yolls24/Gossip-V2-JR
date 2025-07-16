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

  # Méthode utilitaire pour afficher le nom complet
  def full_name
    "#{first_name} #{last_name}"
  end

  # Méthode pour stocker le remember_digest à partir d’un token
  def remember(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    self.update(remember_digest: remember_digest)
  end
end





  

