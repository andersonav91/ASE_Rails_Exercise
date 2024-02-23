# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  validates :selected_option, inclusion: { in: [true, false] }
end
