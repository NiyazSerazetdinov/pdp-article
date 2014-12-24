require 'rails_helper'

describe ArticlesController do

  context 'when unauhorized user' do
    subject { response }

    describe '#index' do
      before { get :index }

      it { is_expected.to be_success }
    end

    describe '#create' do
      context 'with valid params' do
        before { post :create }

        its(:status) { is_expected.to eq(302) }
        it { is_expected.to redirect_to(new_user_session_path) }
      end
    end

    describe '#update' do
      let!(:article) { create(:article) }

      before { patch :update, id: article.id }

      its(:status) { is_expected.to eq(302) }
      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  context 'when authorized user' do
    let(:user) { create(:user, confirmed_at: DateTime.now) }
    let(:params) { { article: { title: 'title', text: 'text' }, format: :html } }

    before { sign_in(user) }
    subject { response }

    describe '#index' do
      before { get :index }

      it { is_expected.to be_success }
    end

    describe '#create' do
      def do_create
        post :create, params
      end

      context 'with valid params' do
        subject { do_create }

        it 'creates new article' do
          expect { subject }.to change { Article.count }.by(1)
        end

        it { expect(response.status).to eq(200) }
      end

      context 'with invalid params' do
        subject { post :create, article: { title: '', text: '' } }

        it 'creates new article' do
          expect { subject }.not_to change { Article.count }
        end

        it { is_expected.to render_template(:new) }
      end
    end

    describe '#update' do
      let!(:article) { create(:article, user: user) }
      let(:new_params) { { title: 'Amazing' } }

      def do_update
        patch :update, id: article.id, article: new_params, format: :html
      end

      subject { response }
      before { do_update }

      context 'with valid params' do
        it { is_expected.to redirect_to(article) }
        it { expect(article.reload.title).to eq('Amazing') }
      end

      context 'with invalid params' do
        let(:new_params) { { title: nil } }

        it { is_expected.to render_template(:edit) }
        it { expect(article.reload.title).to eq('Title') }
      end
    end
  end
end
