require 'spec_helper'

describe ArticlesController do
  let(:user) { create(:user, id: 1, confirmed_at: DateTime.now) }
  let(:params) { { article: { title: "title", text: "text" }, format: :html } }
  before { sign_in(user) }

  describe '#index' do
    before { get :index }
    subject { response }

    it { should be_success }
  end

  describe '#create' do


    def do_create(format)
      post :create, params
    end

    describe '.html' do
      subject { response }

      context 'with valid params' do
        before { create }

        it { should be_success }
        it { should render_template('show') }
      end

      context 'with invalid params' do
        before { create(:title => nil) }

        it { should_not be_success }
        it { should render_template('new') }
      end
    end
  end

  describe '#update' do
    let!(:article) { create(:article, params) }
    let(:new_params) { {title: 'Amazing'} }

    def do_update(format)
      patch :update, :id => article, :article => new_params, format: :html
    end

    describe '.html' do
      subject { response }
      before { do_update('html') }

      context 'with valid params' do
        it { should be_success }
        it { should render_template('show') }
      end

      context 'with invalid params' do
        let(:params) { { :title => nil } }

        it { should_not be_success }
        it { should render_template(:partial => '_form') }
      end
    end
  end
end
