require 'rails_helper'

describe ArticlePresenter do
  let(:user) { build(:user, full_name: 'User Shmuser') }
  let(:article) { create(:article, title: 'shmitle', user: user) }
  let(:presenter) { described_class.wrap(article) }
  let(:today) { Date.today }
  let(:yesterday) { Date.yesterday }

  describe '#publication_info' do
    before { article.created_at = yesterday }
    subject { presenter.publication_info }

    it { is_expected.to eq "Written Yesterday #{ yesterday.strftime('at %I:%M%p')} by User Shmuser" }
  end

  describe '#formated_title' do
    subject { presenter.formated_title }

    it { is_expected.to eq 'Shmitle' }
  end

  describe '#update_date' do
    before { article.updated_at = today }
    subject { presenter.update_date }

    it { is_expected.to eq "Updated Today #{today.strftime('at %I:%M%p')}" }
  end
end
