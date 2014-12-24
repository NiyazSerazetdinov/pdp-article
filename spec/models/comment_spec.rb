require 'rails_helper'

describe Comment do
  it { is_expected.to validate_presence_of :text }
  it { is_expected.to validate_presence_of :article }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:article) }
end
