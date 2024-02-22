class SurveysController < ApplicationController

  ITEMS_PER_PAGE = 10
  def index
    surveys_filter = Survey

    non_empty_filters = params.dig(:filters)&.reject { |_, value| value.blank? }
    survey_filters_list = surveys_filter.where(non_empty_filters&.permit(:user_id))

    if non_empty_filters && non_empty_filters[:title]&.present?
      survey_filters_list = surveys_filter.where("title LIKE ?", "%#{non_empty_filters[:title]}%")
    end

    @surveys = survey_filters_list.page(params[:page]).per(ITEMS_PER_PAGE).order(:created_at)
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.user = current_user
    if @survey.save
      redirect_to surveys_path, notice: 'Survey was successfully created.'
    else
      render :new
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:title)
  end
end
