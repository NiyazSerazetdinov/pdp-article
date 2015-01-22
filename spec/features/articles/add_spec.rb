require 'rails_helper'

feature 'Add Article' do
  let(:user) { create(:user, :confirmed) }
  before do
    login_as user

    visit articles_path
    click_link 'Add Article'
  end

  scenario 'I see article#new page' do
    expect(current_path).to eq new_article_path
    expect(page).to have_css('input#article_title')
    expect(page).to have_css('textarea#article_text')
  end

  scenario 'I submit article with valid data' do
    fill_in 'Title', with: 'Article Title'
    fill_in 'Text', with: 'Article Text'

    click_button 'Create Article'

    expect(current_path).to eq article_path(Article.first.id)
    expect(page).to have_content 'Article Title'
    expect(page).to have_content 'Article Text'
  end

  scenario 'I submit article with invalid data' do
    click_button 'Create Article'

    expect(page).to have_css '.article-errors'
    within('.article-errors') do
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Text can't be blank"
    end
  end
end
