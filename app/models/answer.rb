# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  validates :selected_option, inclusion: { in: [true, false] }

  validate :user_can_only_answer_once_per_survey

  private

  def user_can_only_answer_once_per_survey
    existing_answer = Answer.where(user_id: user_id, survey_id: survey_id).exists?
    errors.add(:user_id, "can only answer once per survey.") if existing_answer
  end
end
