require 'rails_helper'

describe ArticlesController do
  let(:user) { create(:user, id: 1, confirmed_at: DateTime.now) }
  let(:params) { { article: { title: "title", text: "text" }, format: :html } }
  before { sign_in(user) }

  describe '#index' do
    before { get :index }
    subject { response }

    it { is_expected.to be_success }
  end

  describe '#create' do
    def do_create
      post :create, params
    end

    subject { response }

    context 'with valid params' do
      before { do_create }

      it {binding.pry}

      it { is_expected.to be_success }
      it { is_expected.to redirect_to(article) }
    end

    context 'with invalid params' do
      before { create(:title => nil) }

      it { is_expected.to_not be_success }
      it { is_expected.to render_template('articles/new') }
    end
  end

  describe '#update' do
    let!(:article) { create(:article, params) }
    let(:new_params) { {title: 'Amazing'} }

    def do_update
      patch :update, :id => article, :article => new_params, format: :html
    end

    subject { response }
    before { do_update('html') }

    context 'with valid params' do
      it { is_expected.to be_success }
      it { is_expected.to render_template('show') }
    end

    context 'with invalid params' do
      let(:params) { { :title => nil } }

      it { is_expected.to_not be_success }
      it { is_expected.to render_template(:partial => '_form') }
    end
  end
end
