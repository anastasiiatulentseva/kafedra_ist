require 'rails_helper'

RSpec.feature "Articles management" do

  scenario "Admin creates and deletes an article", :js do
    
    visit new_article_path
    expect(page).to have_css 'div.form-group'
    fill_in 'article[name]', with: " "
    click_button 'Save'

    expect(page).to have_css 'div#error_explanation'

    visit new_article_path
    fill_in 'article[name]', with: "About John Smith"
    page.execute_script <<-JS
    $("#article_text").val('About john smith');
    JS
    fill_in 'article[category]', with: "Category about John Smith"
    fill_in 'article[order]', with: "1"
    click_button 'Save'

    expect(page).to have_css 'div.alert-success'
    expect(page).to have_text 'Article has been created'
    expect(page).to have_text 'About John Smith'
    
    find_link('Back to index').click
    expect(page).to have_text 'About John Smith'
    
    click_link('About John Smith')
    find_link('Edit article').click
    expect(page).to have_text 'Delete'
    click_link 'Delete'

    page.driver.browser.switch_to.alert.accept
    expect(page).to have_css 'div.alert'
    expect(page).to_not have_text 'About John Smith'
  end

end
