require 'rails_helper'

describe CommentPresenter do
  let(:user) { build(:user, full_name: 'User Shmuser') }
  let(:comment) { create(:comment, user: user) }
  let(:presenter) { described_class.wrap(comment) }
  let(:yesterday) { Date.yesterday }

  describe '#comment_info' do
    before { comment.created_at = yesterday }
    subject { presenter.comment_info }

    it { is_expected.to eq "Written Yesterday #{ yesterday.strftime('at %I:%M%p')} by User Shmuser" }
  end
end
