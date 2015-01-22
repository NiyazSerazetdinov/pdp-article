require 'rails_helper'

feature 'Add Comment' do
  let(:user) { create(:user, :confirmed) }
  let(:article) { create(:article, user: user) }
  before do
    login_as user

    visit article_path(article)
  end

  scenario 'I see comment form' do
    expect(page).to have_css('form#new_comment')
  end

  scenario 'I submit comment with valid data' do
    fill_in 'comment_text', with: 'Comment Text'

    click_button 'Create Comment'

    expect(page).to have_content 'Comment Text'
  end

  scenario 'I submit comment with invalid data' do
    click_button 'Create Comment'

    expect(current_path).to eq article_path(Article.first.id)
  end
end
