class Report < ApplicationRecord
  belongs_to :user
  
  validates :comment, length: { maximum: 160 }
end
