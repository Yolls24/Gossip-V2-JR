class Like < ApplicationRecord
    belongs_to :user
    belongs_to :likeable, polymorphic: true
  
    validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id], message: "a déjà liké" }
  end
  
  