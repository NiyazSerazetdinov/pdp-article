require 'rails_helper'

describe Article do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to ensure_length_of(:title).is_at_most(60) }
  it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  it { is_expected.to validate_presence_of :text }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
end
