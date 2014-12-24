require 'rails_helper'

describe CommentPresenter do
  let(:user) { build(:user, full_name: 'User Shmuser') }
  let(:comment) { create(:comment, user: user) }
  let(:presenter) { described_class.wrap(comment) }

  describe '#comment_info' do
    before { comment.created_at = Date.yesterday }
    subject { presenter.comment_info }

    it { is_expected.to eq "Written Yesterday #{ Date.yesterday.strftime('at %I:%M%p')} by User Shmuser" }
  end
end
