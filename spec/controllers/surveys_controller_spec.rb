# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveysController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all surveys to @surveys' do
      survey = create(:survey, user:)
      get :index
      expect(assigns(:surveys)).to eq([survey])
    end
  end

  describe 'GET #new' do
    it 'assigns a new Survey to @survey' do
      get :new
      expect(assigns(:survey)).to be_a_new(Survey)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new Survey' do
        expect do
          post :create, params: { survey: attributes_for(:survey) }
        end.to change(Survey, :count).by(1)
      end

      it 'redirects to the surveys index with a notice on successful save' do
        post :create, params: { survey: attributes_for(:survey) }
        expect(response).to redirect_to(surveys_path)
        expect(flash[:notice]).to eq('Survey was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new survey' do
        expect do
          post :create, params: { survey: attributes_for(:survey, title: nil) }
        end.not_to change(Survey, :count)
      end

      it "re-renders the 'new' template" do
        post :create, params: { survey: attributes_for(:survey, title: nil) }
        expect(response).to render_template('new')
      end
    end
  end
end
