# frozen_string_literal: true

class Survey < ApplicationRecord
  belongs_to :user
  has_many :answers
  validates :title, presence: true, length: { maximum: 1000 }

  def percentage_of(option)
    total_answers = answers.count
    return 0 if total_answers.zero?

    option_count = answers.where(selected_option: option).count
    ((option_count.to_f / total_answers) * 100).round(2)
  end
end
