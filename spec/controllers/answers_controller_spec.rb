# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:survey) { create(:survey, user:) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new answer as @answer' do
      get :new, params: { survey_id: survey.id }
      expect(assigns(:answer)).to be_a_new(Answer)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { { selected_option: true, survey_id: survey.id } }

      it 'creates a new Answer' do
        expect do
          post :create, params: { survey_id: survey.id, answer: valid_attributes }
        end.to change(Answer, :count).by(1)
      end

      it 'redirects to the surveys list with a notice' do
        post :create, params: { survey_id: survey.id, answer: valid_attributes }
        expect(response).to redirect_to(surveys_path)
        expect(flash[:notice]).to eq('Your answer was successfully submitted.')
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { selected_option: nil, survey_id: survey.id } }

      it 'does not create a new Answer' do
        expect do
          post :create, params: { survey_id: survey.id, answer: invalid_attributes }
        end.not_to change(Answer, :count)
      end

      it 're-renders the "new" template' do
        post :create, params: { survey_id: survey.id, answer: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end
end
