class AnswersController < ApplicationController
  before_action :set_survey, only: [:new, :create]

  def new
    @answer = Answer.new
  end

  def create
    @answer = @survey.answers.build(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to surveys_path, notice: 'Your answer was successfully submitted.'
    else
      render :new
    end
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def answer_params
    params.require(:answer).permit(:selected_option)
  end
end
