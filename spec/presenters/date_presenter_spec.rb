require "rails_helper"

describe DatePresenter do
  describe "#human_date" do
    let(:date) { Time.now }
    let(:presenter) { described_class.wrap(date) }

    subject { presenter.human_date }

    context "when written today" do
      it { is_expected.to eq "Today #{date.strftime("at %I:%M%p")}" }
    end

    context "when written happened yesterday" do
      let(:date) { 1.day.ago }

      it { is_expected.to eq "Yesterday #{date.strftime("at %I:%M%p")}" }
    end

    context "otherwise" do
      let(:date) { 5.day.ago }

      it { is_expected.to eq "on #{date.strftime("%b %d, %Y")} #{date.strftime("at %I:%M%p")}" }
    end
  end
end
