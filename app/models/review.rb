class Review < ApplicationRecord
  belongs_to :property
  validates :reviewer_name, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
end
