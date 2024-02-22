class Survey < ApplicationRecord
  belongs_to :user
  has_many :answers
  validates :title, presence: true, length: { maximum: 1000 }
end
