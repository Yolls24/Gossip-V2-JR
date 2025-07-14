class Tag < ApplicationRecord
    has_many :taggings, dependent: :destroy
    has_many :gossips, through: :taggings
  end
  
  
  
